import requests
from bs4 import BeautifulSoup
import time

API_KEY = "c319ef507eaa4576d298d6003ea5b5b363b2998a"
query = "In demand skills and certifications for software developers in 2025"

# ---------------- Serper API call ----------------
url = "https://google.serper.dev/search"
headers = {
    "X-API-KEY": API_KEY,
    "Content-Type": "application/json",
}

json_body = {
    "q": query,
    "num": 10
}

resp = requests.post(url, headers=headers, json=json_body, timeout=10)
if resp.status_code != 200:
    print("Error:", resp.status_code, resp.text)
    exit()

data = resp.json()

# ---------------- Collect all URLs ----------------
urls = []
# Organic results
for r in data.get("organic", []):
    urls.append(r.get("link"))
    # Optional: add sitelinks
    for s in r.get("sitelinks", []):
        urls.append(s.get("link"))

# Limit to 10 URLs max
urls = urls[:10]

print(f"Scraping content from {len(urls)} URLs...\n")

# ---------------- Scrape text from each URL ----------------
for i, link in enumerate(urls, start=1):
    try:
        page = requests.get(link, timeout=10)
        soup = BeautifulSoup(page.content, "html.parser")
        # Extract visible text
        text = soup.get_text(separator="\n", strip=True)
        print(f"\n--- URL {i}: {link} ---\n")
        print(text[:2000])  # print first 2000 chars to avoid huge outputs
        time.sleep(1)  # polite delay between requests
    except Exception as e:
        print(f"Failed to scrape {link}: {e}")
