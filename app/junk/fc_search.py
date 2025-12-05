import os
import requests
from firecrawl import FirecrawlApp
from dotenv import load_dotenv

load_dotenv()

SERPER_API_KEY = os.getenv("SERPER_API_KEY")
FIRECRAWL_API_KEY = os.getenv("FIRECRAWL_API_KEY")

firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY)


# -----------------------------------------
# Utility: Filter junk or low-value urls
# -----------------------------------------
def is_valid_url(url: str) -> bool:
    invalid_hosts = [
        "facebook.com", "twitter.com", "linkedin.com", "youtube.com",
        "pinterest.com", "instagram.com"
    ]

    if any(host in url for host in invalid_hosts):
        return False

    # Filter tracking links & duplicates
    if "utm_" in url or "redirect" in url:
        return False

    return True


# -----------------------------------------
# Step 1: SERPER Search
# -----------------------------------------
def search_job_urls(job_title: str, limit: int = 5):
    url = "https://google.serper.dev/search"
    headers = {"X-API-KEY": SERPER_API_KEY, "Content-Type": "application/json"}

    payload = {
        "q": f"{job_title} required skills and certifications 2025"
    }

    resp = requests.post(url, json=payload, headers=headers)
    if resp.status_code != 200:
        raise Exception(f"Serper error {resp.status_code}: {resp.text}")

    data = resp.json()
    urls = []

    if "organic" in data:
        for item in data["organic"]:
            link = item.get("link")
            if link and is_valid_url(link):
                urls.append(link)

    # Deduplicate & take only the top N
    unique_urls = list(dict.fromkeys(urls))[:limit]

    return unique_urls


# -----------------------------------------
# Step 2: Extract clean markdown from Firecrawl
# -----------------------------------------
def extract_markdown(url: str, max_chars: int = 5000):
    print(f"Scraping with Firecrawl → {url}")

    doc = firecrawl.scrape(url, formats=["markdown"])

    # Firecrawl Document object → doc.markdown contains the string
    md = getattr(doc, "markdown", "")

    # Protect in case markdown is None
    if md is None:
        md = ""

    # Trim markdown to avoid LLM overload
    if isinstance(md, str) and len(md) > max_chars:
        md = md[:max_chars] + "\n\n...[TRIMMED]..."

    return {
        "url": url,
        "markdown": md
    }


# -----------------------------------------
# Step 3: Extract results for a given job title
# -----------------------------------------
def extract_in_demand(job_title: str):
    urls = search_job_urls(job_title)

    results = []
    for url in urls:
        try:
            results.append(extract_markdown(url))
        except Exception as e:
            print(f"Error scraping {url}: {e}")

    return results


# -----------------------------------------
# Run Test
# -----------------------------------------
if __name__ == "__main__":
    job = "Data Scientist"
    output = extract_in_demand(job)

    print("\n=== FINAL RESULTS ===")
    for item in output:
        print(f"\n--- {item['url']} ---\n")
        print(item["markdown"])
