# User Agents

# Initialize Memory for a new user
walker initialize_memory {
    has email: str = "";
    has full_name: str= "";

    can initialize_memory with `root entry;
}