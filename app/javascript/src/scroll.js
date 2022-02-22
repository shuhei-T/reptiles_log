$(document).on('DOMContentLoaded', function() {
  $('.jscroll').jscroll({
    // 無限に追加する要素はどこに入れるか
    contentSelector: '.jscroll',
    // 次のページにいくためのリンクの場所は? >aタグの指定
    nextSelector: 'span.next:last a',
    // 読み込み中の表示はどうするか
    // loadingHtml: '読込中'
  });
});
