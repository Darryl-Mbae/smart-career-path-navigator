import requests

# -------------------------
# Careerjet API Credentials
# -------------------------
hostname = 'search.api.careerjet.net'
path = '/v4/query'
api_key = 'cc5638024c6473dc2afe1dc8633ed5b1'     # Your provided API key

# -------------------------
# Headers and Request Setup
# -------------------------
referer = 'https://www.agriscan.jhubafrica.com/find-jobs/'
public_ip = '154.159.237.75'

params = {
    'locale_code': 'en_US',
    'keywords': 'Civil Engineer',
    'location': 'New York',
    'user_ip': public_ip,
    'user_agent': 'Mozilla/5.0',
    'fragment_size': 1000,  # Increase fragment size for longer descriptions
    'page_size': 100,       # Number of jobs per page
    'page': 100,
    'sort': 'date',        # Sort by most recent
}

headers = {
    'content-type': 'application/json',
    'Referer': referer,
}

# -------------------------
# Perform the API Request
# -------------------------
try:
    print("Sending request to Careerjet API...")

    response = requests.get(
        url=f'https://{hostname}{path}',
        params=params,
        auth=(api_key, ''),  
        headers=headers,
        timeout=10
    )

    print("Status Code:", response.status_code)

    data = response.json()

    print("\n--- Job Descriptions ---")
    for job in data.get('jobs', []):
        title = job.get('title', 'No title')
        company = job.get('company', 'No company')
        location = job.get('locations', 'No location')
        description = job.get('description', 'No description')

        print(f"\nJob Title: {title}")
        print(f"Company: {company}")
        print(f"Location: {location}")
        print(f"Description:\n{description}")

except Exception as e:
    print("Request failed:", str(e))
