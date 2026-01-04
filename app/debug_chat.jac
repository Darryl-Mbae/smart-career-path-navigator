import from app { career_chat }


walker debug_chat {
    can run with `root entry {
        print("Sending message to career_chat...");
        result =
            root spawn career_chat(
                user_id="test_user",
                message="Hello, can you add Python to my skills?",
                focus_area="General guidance"
            );
        print("Raw Result:");
        print(result);
        if result.reports {
            print("Reports found:");
            for r in result.reports {
                print(r);
            }
        } else {
            print("No reports found!");
        }
    }
}


with entry {
    root spawn debug_chat();
}
