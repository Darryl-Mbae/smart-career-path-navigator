import base64;
import re;
import os;
import PyPDF2;
import docx;
import datetime;


# Helpers
 def read_document_text(file_path: str) -> str {
    if not os.path.exists(file_path) {
        return "";
    }
    file_path_lower = file_path.lower();
    try {
        # PDF READER
         if file_path_lower.endswith(".pdf") {
            text = "";
            with open(file_path, "rb") as f  {
                reader = PyPDF2.PdfReader(f);
                for page in reader.pages {
                    text += page.extract_text() or "" ;
                }
            }
            return text.strip();
        } # DOCX READER
         elif file_path_lower.endswith(".docx") {
            doc = docx.Document(file_path);
            text = "\n".join([ para.text for para in doc.paragraphs ]);
            return text.strip();
        } else {
            return "";
        }
    } except Exception as e {
        print(f"[ERROR] Failed to read document: {e}");
        return "";
    }
}


def _utc_now_dt()  -> any {
    return datetime.datetime.utcnow().replace(microsecond=0);
}


def _iso_from_dt(dt: any) -> str {
    return dt.isoformat() + "Z";
}


def _eat_from_utc_dt(dt: any) -> str {
    let eat_dt = dt + datetime.timedelta(hours=3);
    return eat_dt.strftime("%Y-%m-%d %H:%M:%S EAT");
}


def _safe_str(x: any) -> str {
    if x == None {
        return "";
    }
    return str(x);
}


def _contains(hay: any, needle: any) -> bool {
    let h = _safe_str(hay).lower();
    let n = _safe_str(needle).lower();
    if h == "" or n == ""  {
        return False;
    }
    return h.find(n) != -1;
}


def _normalize_title_for_freq(title: any) -> str {
    let t = _safe_str(title).strip();
    if t == "" {
        return "";
    }
    let lowers = t.lower();
    let tokens =

        ["senior",
        "jr",
        "junior",
        "lead",
        "principal",
        "intern",
        "internship",
        "mid-level",
        "mid level"];
    for w in tokens {
        lowers = lowers.replace(w, "");
    }
    let parts = lowers.split();
    let out = "";
    for p in parts {
        if p.strip() == "" {
            continue;
        }
        if out == "" {
            out = p;
        } else {
            out = out + " " + p;
        }
    }
    return out.title();
}


def _freq_top(items: any, top_n: int = 10) -> list[str] {
    let freq = {};
    for x in (items if items else []) {
        let s = _safe_str(x).strip();
        if s == "" {
            continue;
        }
        if s in freq {
            freq[s] = freq[s] + 1;
        } else {
            freq[s] = 1;
        }
    }
    let pairs = [];
    for k in freq.keys() {
        pairs.append({"k" : k , "v" : freq[k] });
    }
    let i = 0;
    while i < len(pairs) {
        let j = i + 1;
        while j < len(pairs) {
            if pairs[j]["v"] > pairs[i]["v"] {
                let tmp = pairs[i];
                pairs[i] = pairs[j];
                pairs[j] = tmp;
            }
            j = j + 1;
        }
        i = i + 1;
    }
    let out = [];
    let idx = 0;
    while idx < len(pairs) and len(out) < top_n  {
        out.append(_safe_str(pairs[idx]["k"]));
        idx = idx + 1;
    }
    return out;
}


def _build_snapshot_from_jobs(jobs: any) -> dict {
    let role_titles = [];
    let tags = [];
    for j in (jobs if jobs else []) {
        if j == None {
            continue;
        }
        let t = _normalize_title_for_freq(j.get("title", ""));
        if t != "" {
            role_titles.append(t);
        }
        let jt = j.get("tags", []) if j else [];
        for tag in (jt if jt else []) {
            let tg = _safe_str(tag).strip();
            if tg != "" {
                tags.append(tg);
            }
        }
    }
    let top_roles = _freq_top(role_titles, top_n=12);
    let top_skills = _freq_top(tags, top_n=16);
    return {"top_roles" : top_roles , "top_skills" : top_skills };
}


def _filter_jobs_by_focus(jobs: any, focus: any) -> list[dict] {
    if focus == None {
        return jobs if jobs else [];
    }
    let f = _safe_str(focus).strip().lower();
    if f == "" or f == "all"  {
        return jobs if jobs else [];
    }
    let out = [];
    for j in (jobs if jobs else []) {
        if j == None {
            continue;
        }
        let title = _safe_str(j.get("title", "")).lower();
        let tags = j.get("tags", []) if j else [];
        let tag_join = "";
        for t in (tags if tags else []) {
            let ts = _safe_str(t).lower();
            if ts.strip() == "" {
                continue;
            }
            if tag_join == "" {
                tag_join = ts;
            } else {
                tag_join = tag_join + " " + ts;
            }
        }
        if _contains(title, f) or _contains(tag_join, f)  {
            out.append(j);
        }
    }
    return out;
}


def clean_reply_text(text: str) -> str {
    if not text {
        return "";
    }
    let s = "" + text;
    try {
        s = re.sub(r"(?i)^\s*smart\s+career\s+path\s+navigator\s*:\s*", "", s);
    } except Exception as e { }
    return s.strip();
}
