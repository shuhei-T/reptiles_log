$(document).on('DOMContentLoaded', function() {
  // 記録画像モーダル表示イベント
  $(document).on("click", ".course-item img", function() {
    $('body').css('overflow-y', 'hidden');
    // まず、クリックした画像の HTML(<img>タグ全体)を#grayDisplay内にコピー
    $("#grayDisplay").html($(this).prop("outerHTML"));
    //そして、fadeInで表示する。
    $("#grayDisplay").fadeIn(200);
    return false;
  });
  // 記録画像モーダル非表示イベント
  // モーダル画像背景 または 拡大画像そのものをクリックで発火
  $("#grayDisplay").click(function () {
    $('body').css('overflow-y','auto');
    // 非表示にする
    $("#grayDisplay").fadeOut(200);
    return false;
  });
});