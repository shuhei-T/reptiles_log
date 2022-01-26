$(document).on('turbolinks:load', function() {
  let dataController = $('body').attr('data-controller');
  let dataAction = $('body').attr('data-action');

  if (dataController == 'reptiles' && (dataAction == 'new' || dataAction == 'create' || dataAction == 'edit' || dataAction == 'update')) {
    let $birthday = $('#birthday_birthday_1i,#birthday_birthday_2i,#birthday_birthday_3i');
    let birthdayArray = ["","",""];

    if ($birthday.val() != ""){
      disable_JoinAge();
    }


    $('#check_birthday').change(function() {
      $('#birthday_birthday_1i').parent('div').toggleClass('disable');
      $birthday.val('');
      birthdayArray.map( function( value, index, array ) {
        array[index] = "";
        enable_JoinAge();
      });
    });

    $birthday.change(function() {
      birthdayArray[$birthday.index(this)] = $(this).val();
      if (birthdayArray.includes("") == false){
        disable_JoinAge();
      }else{
        enable_JoinAge();
      }
    });

    function disable_JoinAge() {
      $('#raw_age,#label_age').addClass('disable');
      $('.age_comment').removeClass('hidden');
    }
    function enable_JoinAge() {
      $('#raw_age,#label_age').removeClass('disable');
      $('.age_comment').addClass('hidden');
    }
  }
});