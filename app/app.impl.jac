impl initialize_memory.initialize_memory {

        new_memory = here ++> Memory(email=self.email, full_name=self.full_name);
        report {"status": "Success", "message": "Memory initialized", "body": new_memory};

}

impl create_resume_node.create_resume_node {
        new_resume = here ++> Resume();
        report {"status": "Success", "message": "Resume node created", "body": new_resume};
}

impl upload_resume.visit_resume {
        print("Visiting Resume Node");
        visit [-->(`?Resume)];
}

impl upload_resume.upload_resume {

        here.name = self.name;
        here.mime = self.mime;

        try {
            let decoded_bytes = base64.b64decode(self.file);
            here.content = decoded_bytes;
        }
        except Exception as e {
            print(f"Base64 decode error: {e}");
            report {"status": "Fail", "message": "Failed to decode resume file", "body": {}};
            disengage;
        }

        print(f"File bytes saved, size = {len(here.content)} bytes");

        report {
            "status": "Success",
            "message": "Resume uploaded",
            "body": {
                "name": here.name,
                "mime": here.mime,
                "size_bytes": len(here.content)
            }
        };
}

impl update_resume_upload_status.check_memory {
        visit [-->(`?Memory)];
}

impl update_resume_upload_status.update_resume_upload_status {
        here.resume_uploaded = True;
        report {"status": "Success", "message": "Resume upload status updated", "body": here.resume_uploaded};
}

impl check_resume_upload_status.check_memory  {
        visit [-->(`?Memory)];
}

impl check_resume_upload_status.check_resume_upload_status {
        report {"status": "Success", "message": "", "body": here.resume_uploaded};
}
