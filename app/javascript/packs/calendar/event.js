import { Calendar } from '@fullcalendar/core';
import monthGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import googleCalendarApi from "@fullcalendar/google-calendar";
import bootstrap5Plugin from '@fullcalendar/bootstrap5';
import 'bootstrap-icons/font/bootstrap-icons.css';
import '@fullcalendar/common/main.css';
import '@fullcalendar/daygrid/main.css';
import { Modal } from 'bootstrap/dist/js/bootstrap.esm.min.js';
require("@nathanvda/cocoon")

// <div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作る
document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('calendar');
  let calendar = new Calendar(calendarEl, {
    plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi, bootstrap5Plugin ],
    eventSources: [
      {
        googleCalendarApiKey: process.env.GOOGLE_CALENDAR_API_KEY,
        googleCalendarId: 'japanese__ja@holiday.calendar.google.com',
        display: 'background',
        color: '#ffd4d4',
        className: 'holiday-event',
      }
    ],
    // initialView: 'dayGridMonth',
    events: 'events.json',
    // 細かな設定
    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    firstDay: 0,
    themeSystem: 'bootstrap5',
    nowIndicator: true,
    headerToolbar: {
      start: 'prev,next',
      center: 'title',
      end: 'today',
    },
    expandRows: true,
    stickyHeaderDates: true,
    buttonText: {
      today: '今日',
      month: '月',
      week: '週',
      day: '日',
      list: 'リスト'
    },
    allDayText: '終日',
    height: "auto",

    // 日付をクリックした時に発生させるイベント
    dateClick: function(info){
      // クリックした日付の情報を取得
      const year = info.date.getFullYear();
      const month = (info.date.getMonth() + 1);
      const day = info.date.getDate();
      // ajaxでevents/newを着火させ、htmlを受け取る
      $.ajax({
        type: 'GET',
        url: 'events/new',
      }).done(function (res) {
        // 成功処理
        // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入
        $('#modal').html(res);
        let modal = document.getElementById('modal')
        let modalObj = new Modal(modal)
        modalObj.show();

        // フォームの年、月、日を自動入力
        $('#log_logged_at_1i').val(year);
        $('#log_logged_at_2i').val(month);
        $('#log_logged_at_3i').val(day);

        let $addFieldBtn = $('.js-add-log_feeds-field-btn');
        let counter = 1;
        let $cocoonField = $('#activity-logs');
        let $headerFeedName = $('#js-feed-name');
        let $feedAmount = 5;
  
        console.log($cocoonField);

        // cocoonのコールバック
        $cocoonField
        .on('cocoon:after-insert', function() {
          console.log("cocoonコールバック after-insert");
          counter++;
          checkCount(counter);
        })
        .on('cocoon:before-remove', function(event) {
          console.log("cocoonコールバック before-remove");
          // 削除ボタンを押すとアラートメッセージが入る
          let confirmation = confirm('給餌記録を削除します。よろしいですか？');
          if(!confirmation) {
            event.preventDefault();
          }
        })
        .on('cocoon:after-remove', function() {
          console.log("cocoonコールバック after-remove");
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
            console.log("chckout関数 count >= $feedAmount");
          } else if (count < $feedAmount) {
            $addFieldBtn.prop('disabled', false);
            $addFieldBtn.removeClass('disabled');
            console.log("chckout関数 count < $feedAmount");
          }
        };

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

      }).fail(function (result) {
        // 失敗処理
        alert("new failed");
      });
    },
    eventClick: function(info){
      // 表示されたイベントをクリックしたときのイベント
      let $showId = (info.event.id);
      $.ajax({
        type: 'GET',
        url: 'events/' + $showId,
      }).done(function(res) {
      // 成功処理
      $('#modal').html(res);
        let modal = document.getElementById('modal')
        let modalObj = new Modal(modal)
        modalObj.show();

      // コース画像モーダル表示イベント
      $(".course-item img").click(function () {
        // まず、クリックした画像の HTML(<img>タグ全体)を#frayDisplay内にコピー
        $("#grayDisplay").html($(this).prop("outerHTML"));
        //そして、fadeInで表示する。
        $("#grayDisplay").fadeIn(200);
        return false;
      });
      // コース画像モーダル非表示イベント
      // モーダル画像背景 または 拡大画像そのものをクリックで発火
      $("#grayDisplay").click(function () {
        // 非表示にする
        $("#grayDisplay").fadeOut(200);
        return false;
      });

      }).fail(function (result) {
      //   // 失敗処理
        alert("show failed");
        console.log(result);
      });
    },
    eventClassNames: function(arg){
      // 表示されたイベントにclassをcss用に追加する
    }
  });
  // カレンダー表示
  calendar.render();

  // 成功、失敗modalを閉じたときに予定を再更新してくれる
  // これがないと追加しても自動更新されない
  $(function(){
    $(document).on('click', '#fetch', function(){
      calendar.refetchEvents();
    });
  });
});