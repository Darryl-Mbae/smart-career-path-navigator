import os;
import requests;
import from firecrawl { FirecrawlApp }
with entry {
    let SERPER_API_KEY = os.getenv('SERPER_API_KEY');
    let FIRECRAWL_API_KEY = os.getenv('FIRECRAWL_API_KEY');
    let firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY);
}
def is_valid_url(url: str) -> bool {
    let invalid_hosts = [
        'facebook.com',
        'twitter.com',
        'linkedin.com',
        'youtube.com',
        'pinterest.com',
        'instagram.com'
    ];
    if <>any((host in url) for host in invalid_hosts) {
        return False;
    }
    if (('utm_' in url) or ('redirect' in url)) {
        return False;
    }
    return True;
}
def search_job_urls(job_title: str, limit: int = 5) {
    let url = 'https://google.serper.dev/search';
    let headers = {'X-API-KEY': SERPER_API_KEY, 'Content-Type': 'application/json'};
    let payload = {'q': f"{job_title} required skills and certifications 2025"};
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
    return <>list(<>dict.fromkeys(urls))[:limit];
}
def extract_markdown(url: str, max_chars: int = 5000) {
    let doc = firecrawl.scrape(url, formats=['markdown']);
    let md = getattr(doc, 'markdown', '') or '';
    if (isinstance(md, str) and (len(md) > max_chars)) {
        let md = md[:max_chars] + '\n\n...[TRIMMED]...';
    }
    return {'url': url, 'markdown': md};
}
def search_job_requirements(job_title: str) {
    let urls = search_job_urls(job_title);
    let out = [];
    for url in urls {
        try {
            out.append(extract_markdown(url));
        } except Exception as e {
            out.append({'url': url, 'markdown': f"ERROR: {e}"});
        }
    }
    return out;
}

