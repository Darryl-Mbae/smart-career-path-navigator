# Helpers 
def read_document_text(file_path: str) -> str{

    if not os.path.exists(file_path){

        return "";
    }
    file_path_lower = file_path.lower();

    try{
 
        # PDF READER
        if file_path_lower.endswith(".pdf"){
            text = "";
            with open(file_path, "rb") as f {
                reader = PyPDF2.PdfReader(f);
                for page in reader.pages {
                    text += page.extract_text() or "";
                }
            }
            return text.strip();
        }

        # DOCX READER
        elif file_path_lower.endswith(".docx"){
            doc = docx.Document(file_path);
            text = "\n".join([para.text for para in doc.paragraphs]);
            return text.strip();
        }
        else{
            return "";
        }
    }
    except Exception as e {
        print(f"[ERROR] Failed to read document: {e}");
        return "";
    }

}