import json
import urllib.request, urllib.parse, urllib.error

# --------------------------
# OnetWebService class
# --------------------------
class OnetWebService:
    def __init__(self, api_key):
        self._headers = {
            'User-Agent': 'python-OnetWebService/2.00 (bot)',
            'X-API-Key': api_key,
            'Accept': 'application/json'
        }
        self._url_root = 'https://api-v2.onetcenter.org/online/'

    def call(self, path, *query):
        try:
            url = self._url_root + path
            if len(query) > 0:
                url += '?' + urllib.parse.urlencode(query, True)
            req = urllib.request.Request(url, None, self._headers)
            try:
                handle = urllib.request.urlopen(req)
            except urllib.error.HTTPError as e:
                try:
                    return json.load(e)
                except:
                    return { "error": f"HTTP error {e.code}" }
            except urllib.error.URLError as e:
                return { "error": f"URL error {e.reason}" }
            try:
                return json.load(handle)
            except:
                return { "error": "Invalid JSON response" }
        except Exception as e:
            return { "error": str(e) }


# --------------------------
# Script: Fetch ML Skills and Certifications
# --------------------------
if __name__ == "__main__":
    API_KEY = "0XFqF-vrHAb-22gFr-ShqCH"  # Replace with your real O*NET API key
    client = OnetWebService(API_KEY)

    job_keyword = "Software Engineer"

    # 1️⃣ Search occupations by keyword
    search_results = client.call("occupations", ("keyword", job_keyword))

    if "occupation" not in search_results or len(search_results["occupation"]) == 0:
        print("No occupations found for:", job_keyword)
        exit()

    # 2️⃣ Pick the first (most relevant) occupation
    top_occupation = search_results["occupation"][0]
    code = top_occupation["code"]
    title = top_occupation["title"]
    print(f"\nTop occupation: {title} (code {code})\n")

    # 3️⃣ Fetch detailed occupation info
    details = client.call(f"occupations/{code}/details")

    # 4️⃣ Extract skills
    skills = []
    for skill in details.get("skills", []):
        name = skill.get("name", "")
        importance = skill.get("importance", "")
        skills.append(f"{name} (importance: {importance})")

    # 5️⃣ Extract credentials / certifications
    certifications = []
    for cred in details.get("credentials", []):
        cred_name = cred.get("title", "")
        provider = cred.get("source", "")
        certifications.append(f"{cred_name} ({provider})")

    # 6️⃣ Print results
    print("Skills required:")
    for s in skills:
        print("-", s)

    print("\nCertifications / Credentials:")
    for c in certifications:
        print("-", c)
