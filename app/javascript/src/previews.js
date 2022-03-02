$(document).on('DOMContentLoaded', function() {
  // $('#log_images').on('change', function (e) {
  $(document).on("change", "#log_images", function(e) {
    if(e.target.files.length > 5){
      alert('一度に投稿できるのは5枚までです');
      // 5枚以上の画像を選択していた場合、選択したファイルをリセット
      $('#log_images').val = '';

      // 以前の画像が残っていた場合は、まだ画像選択できていると勘違いを誘発するため初期化
      for(let i = 0; i < 5; i++) {
        $(`#preview_${i}`).attr('src', '');
      }

    } else {
      let reader = new Array(5);

      // 画像選択を2回した時、1回目より数が少なかったりすると画面上に残るので初期化
      for(let i = 0; i < 5; i++) {
        $(`#preview_${i}`).attr('src', '');
      }

      for(let i = 0; i < e.target.files.length; i++) {
        reader[i] = new FileReader();
        reader[i].onload = finisher(i,e);
        reader[i].readAsDataURL(e.target.files[i]);
        
        //onloadは別関数で準備しないとfor文内では使用できないので、関数を準備。
        function finisher(i, e) {
          return function (e) {
            $(`#preview_${i}`).attr('src', e.target.result);
            $(`#preview_${i}`).addClass('preview_size');
          }
        } 
      }
    }
  });
});