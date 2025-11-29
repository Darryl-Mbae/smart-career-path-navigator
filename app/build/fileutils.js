export function fileToBase64(file) {
  return new Promise(function (resolve, reject) {
    var reader = new FileReader();

    // Read as binary string
    reader.readAsBinaryString(file);
    reader.onload = function () {
      var base64String = btoa(reader.result);
      resolve(base64String);
    };
    reader.onerror = function (error) {
      reject(error);
    };
  });
}