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
