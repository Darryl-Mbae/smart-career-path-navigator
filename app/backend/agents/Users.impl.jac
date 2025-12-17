impl initialize_memory.initialize_memory {
    new_memory = here ++> Memory(email=self.email, full_name=self.full_name);
    report {"status": "Success", "message": "Memory initialized", "body": new_memory};
}