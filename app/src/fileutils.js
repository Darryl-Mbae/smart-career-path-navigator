// Convert file to base64
export function fileToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();

        // Read as binary string
        reader.readAsBinaryString(file);

        reader.onload = () => {
            const base64String = btoa(reader.result);
            resolve(base64String);
        };

        reader.onerror = (error) => {
            reject(error);
        };
    });
}

// convert base64 to file
export function base64ToFileBytes(base64String) {
    return new Promise((resolve, reject) => {
        try {
            // Decode base64 to binary string
            const binaryString = atob(base64String);

            // Convert binary string to byte array
            const bytes = new Uint8Array(binaryString.length);
            for (let i = 0; i < binaryString.length; i++) {
                bytes[i] = binaryString.charCodeAt(i);
            }

            resolve(bytes);
        } catch (error) {
            reject(error);
        }
    });
}
