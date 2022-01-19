function previewImage() {
  const target = this.event.target;
  const file = target.files[0];
  const reader = new FileReader();
  // console.log("hello");
  // debugger
  reader.onloadend = function () {
    const preview = document.querySelector("#preview")
    if(preview) {
      preview.src = reader.result;
    }
  }
  if (file) {
    reader.readAsDataURL(file);
  }
}