import from dotenv { load_dotenv }
import from dotenv { load_dotenv }
import base64;
import re;
import os;
import PyPDF2;
import docx;
import requests;
import json;
import from firecrawl { FirecrawlApp }

# Tools
# Job recommender tools
def is_valid_url(url: str) -> bool {
    let invalid_hosts = [
        'facebook.com',
        'twitter.com',
        'linkedin.com',
        'youtube.com',
        'pinterest.com',
        'instagram.com'
    ];
    if any((host in url) for host in invalid_hosts) {
        return False;
    }
    if (('utm_' in url) or ('redirect' in url)) {
        return False;
    }
    return True;
}
def search_job_urls(job_title: str, limit: int = 2) -> list {
    let url = 'https://google.serper.dev/search';
    let headers = {'X-API-KEY': SERPER_API_KEY, 'Content-Type': 'application/json'};
    let payload = {'q': f"{job_title}mandatory required in  demand  skills and certifications 2025"};
    let resp = requests.post(url, json=payload, headers=headers);
    if (resp.status_code != 200) {
        raise Exception(f"Serper error {resp.status_code}: {resp.text}") ;
    }
    let data = resp.json();
    let urls = [];
    if ('organic' in data) {
        for item in data['organic'] {
            let link = item.get('link');
            if (link and is_valid_url(link)) {
                urls.append(link);
            }
        }
    }
    return list(dict.fromkeys(urls))[:limit];
}


def search_job_requirements(job_title: str) -> str {

    let urls = search_job_urls(job_title);
    let out = [];

    for url in urls {
        try {
            let md = extract_markdown(url);

            out.append({
                "url": url,
                "markdown": md
            });

        } except Exception as e {
            out.append({
                "url": url,
                "markdown": f"ERROR: {e}"
            });
        }
    }

    return json.dumps(out);
}

def fetch_careerjet_descriptions(job_title: str) -> str {

    let hostname = 'search.api.careerjet.net';
    let path = '/v4/query';
    let api_key = 'cc5638024c6473dc2afe1dc8633ed5b1';

    let params = {
        'locale_code': 'en_US',
        'keywords': job_title,
        'location': '',
        'user_ip': '154.159.237.212',
        'user_agent': 'Mozilla/5.0',
        'fragment_size': 1000,
        'page_size': 50,
        'page': 1,
        'sort': 'date'
    };

    let headers = {
        'content-type': 'application/json',
        'Referer': 'https://www.agriscan.jhubafrica.com/find-jobs/'
    };

    try {
        let resp = requests.get(
            url=f'https://{hostname}{path}',
            params=params,
            auth=(api_key, ''),
            headers=headers,
            timeout=10
        );

        let data = resp.json();

        let descriptions = [
            job.get('description', '')
            for job in data.get('jobs', [])
            if ('description' in job)
        ];

        # Return as JSON string (required for LLM tools)
        return json.dumps({
            "descriptions": descriptions
        });

    } except Exception as e {
        return json.dumps({
            "error": str(e)
        });
    }
}

#Learning path tools



def search_urls(search_phrase: str, limit: int = 2) -> list {
    let url = "https://google.serper.dev/search";
    let headers = {
        "X-API-KEY": SERPER_API_KEY,
        "Content-Type": "application/json",
    };

    # Replace job-title prompt with general-purpose Web search phrase
    let payload = {
        "q": f"{search_phrase} learning resources required skills certifications 2025"
    };

    let resp = requests.post(url, json=payload, headers=headers);

    if resp.status_code != 200 {
        raise Exception(f"Serper error {resp.status_code}: {resp.text}");
    }

    let data = resp.json();
    let urls = [];

    if "organic" in data {
        for item in data["organic"] {
            let link = item.get("link");
            if link and is_valid_url(link) {
                urls.append(link);
            }
        }
    }

    # Remove duplicates while keeping order
    let deduped = [];
    for u in urls {
        if u not in deduped {
            deduped.append(u);
        }
    }

    return deduped[:limit];
}


def extract_markdown(url: str, max_chars: int = 5000) -> dict {
    let doc = firecrawl.scrape(url, formats=["markdown"]);

    let md = getattr(doc, "markdown", "");
    if not isinstance(md, str) {
        md = "";
    }

    if len(md) > max_chars {
        md = md[:max_chars] + "\n\n...[TRIMMED]...";
    }

    return {
        "url": url,
        "markdown": md,
    };
}


import from concurrent.futures { ThreadPoolExecutor, as_completed }

def search_learning_resources(search_phrases: list[str]) -> str {
    results = [];

    def scrape_phrase_safe(search_phrase: str) {
        try {
            urls = search_urls(search_phrase);
            phrase_results = [];

            def scrape_safe(url: Any) {
                try {
                    return extract_markdown(url);
                } except Exception {
                    return None;
                }
            }

            with ThreadPoolExecutor(max_workers=5) as executor {
                future_to_url = {
                    executor.submit(scrape_safe, url): url
                    for url in urls
                };

                for future in as_completed(future_to_url) {
                    data = future.result();
                    if data {
                        phrase_results.append(data);
                    }
                }
            }

            return {
                "search_phrase": search_phrase,
                "results": phrase_results
            };

        } except Exception {
            return None;
        }
    }

    # Parallel execution for all search phrases
    with ThreadPoolExecutor(max_workers=5) as executor {
        futures = [
            executor.submit(scrape_phrase_safe, phrase)
            for phrase in search_phrases
        ];

        for future in as_completed(futures) {
            data = future.result();
            if data {
                results.append(data);
            }
        }
    }

    return json.dumps(results);
}




# URL validity
def is_learning_url(url: str) -> bool {
    let banned_hosts = [
        "facebook.com",
        "twitter.com",
        "instagram.com",
        "reddit.com",
        "pinterest.com",
        "tiktok.com",
        "linkedin.com",   # remove for learning?
        "youtube.com"     # remove if you don’t want video resources
    ];

    for host in banned_hosts {
        if host in url {
            return False;
        }
    }

    if ("utm_" in url) or ("redirect" in url) {
        return False;
    }

    return True;
}

#Search Reliable Learning URLs ONLY
def search_learning_links(search_phrase: str, limit: int = 10) -> list {
    let url = "https://google.serper.dev/search";
    let headers = {
        "X-API-KEY": SERPER_API_KEY,
        "Content-Type": "application/json"
    };

    # Focus search specifically on learning resources
    let payload = {
        "q": f"{search_phrase} best tutorials official documentation step-by-step course learning guide 2025"
    };

    let resp = requests.post(url, json=payload, headers=headers);

    if resp.status_code != 200 {
        raise Exception(f"Serper error {resp.status_code}: {resp.text}");
    }

    let results = resp.json();
    let collected = [];

    if "organic" in results {
        for hit in results["organic"] {
            let link = hit.get("link");

            if link and is_learning_url(link) {
                collected.append(link);
            }
        }
    }

    # Cleanup: remove duplicates
    let deduped = [];
    for u in collected {
        if u not in deduped {
            deduped.append(u);
        }
    }

    return deduped[:limit];
}

with entry {
    load_dotenv();
    let SERPER_API_KEY = os.getenv('SERPER_API_KEY');
    let FIRECRAWL_API_KEY = os.getenv('FIRECRAWL_API_KEY');
    let firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY);
}