document.addEventListener('DOMContentLoaded', function() {
  let $addFieldBtn = $('.js-add-log_feeds-field-btn')
      counter = 1
      $cocoonField = $('#activity-logs')
      $headerFeedName = $('#js-feed-name')
      $feedAmount = 5

  // cocoonのコールバック
  $cocoonField
  .on('cocoon:after-insert', function() {
    counter++;
    checkCount(counter);
  })
  .on('cocoon:before-remove', function(event) {
    // 削除ボタンを押すとアラートメッセージが入る
    let confirmation = confirm('給餌記録を削除します。よろしいですか？');
    if(!confirmation) {
      event.preventDefault();
    }
  })
  .on('cocoon:after-remove', function() {
    // 給餌数のカウントを減らす
    counter--;
    checkCount(counter);

    // 新しいnameListを定義
    let nameList = [],
    $nestedFields = $cocoonField.find('.nested-fields'),
    selectForms = [];

    // 編集時には、削除したフォームがdisplay: noneで画面内に残るので
    // $nestedFieldから計算用の配列を作成する
    selectForms = filterVisibleField($nestedFields, selectForms)

    let listToCheck = getNameList(selectForms, nameList);

    // エラー関連のcssを削除する
    if (checkSameValue(listToCheck)) {
      removeErrorClasses();
    }
  });

  // 一定の数以上にフィールドを生成しない処理 -------------------------
  function checkCount(count) {
    if (count >= $feedAmount) {
      // 要素はdisabledのpropで動作しなくなるが、見た目はdisabledを付けないと変化しない
      $addFieldBtn.prop('disabled', true);
      $addFieldBtn.addClass('disabled');
    } else if (count < $feedAmount) {
      $addFieldBtn.prop('disabled', false);
      $addFieldBtn.removeClass('disabled');
    }
  }

  // 見えないフィールドをnameList作成から除外するメソッド
  function filterVisibleField($nestedFields, selectForms) {
    $nestedFields.each(function(i, field) {
      if ($(field).css('display') !== 'none') {
        
        let $selectForm = $($(this).find('select'))
        selectForms.push($selectForm)
      }
    })
    return selectForms
  }

  // 名前が重複していることを通知する処理----------------
  $(document).on("change", ".js-select-form", function(event) {
    let blankList = [];
    alertMessage = document.createElement('span');
    alertContent = document.createTextNode('給餌が重複しています');
    $nestedFields = $cocoonField.find('.nested-fields');
    selectForms = [];

    // エラーメッセージを作成する
    alertMessage.appendChild(alertContent);
    alertMessage.setAttribute('class', 'c-error-message');

    selectForms = filterVisibleField($nestedFields, selectForms)
    let listToCheck = getNameList(selectForms, blankList);

    if (checkSameValue(listToCheck)) {
      removeErrorClasses();
    } else {
      if (!$('.c-error-message').length) {
        $headerFeedName.append(alertMessage);
      }
    }
  });

  // エラー関連のcss削除
  function removeErrorClasses() {
    $('.c-error-message').remove();
  }

  // セレクトフォームの選択中の項目の配列を作る
  function getNameList(selectForms, nameList) {
    selectForms.filter(form => {
      let name = $(form).children("option:selected").text()
      if (name != '選択してください') {
        nameList.push(name);
      }
    })
    return nameList
  }

  // 作った配列の中に、重複した名前が無いか判定
  function checkSameValue(array) {
    let uniqArray = new Set(array);
    if(array.length === 1) {
      return true;
    } else if (uniqArray.size === array.length) {
      return true;
    } else {
      return false;
    }
  }

  // 給餌の画像を出す処理
  $(document).on("change", ".js-select-form", function() {
    // 選択したoptionのvalueを取得
    let val = $(this).val();
    // 親要素から画像リストを取得
    let $imageList = $(this).parent().parent().find('ul li');
    // 先頭に#を付けてvalueの値をidに変換
    let selectFeedId = '#' + val;
    // 一度すべてのブロックを非表示にする
    $imageList.hide();
    // 選択したブロックのみを表示
    if (selectFeedId === '#') {
      return 
    } else {
      $(this).parent().parent().find('ul').find(selectFeedId).show(); 
    }
  });
});