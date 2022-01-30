
$(document).on('DOMContentLoaded', function() {
  $('#reptile_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });

  $('#user_avatar').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});