import { Calendar } from '@fullcalendar/core';
import monthGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import googleCalendarApi from "@fullcalendar/google-calendar";
import listPlugin from "@fullcalendar/list";
import bootstrapPlugin from "@fullcalendar/bootstrap";
import { Modal } from 'bootstrap/dist/js/bootstrap.esm.min.js';

// // <div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作る
document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('calendar');

  let calendar = new Calendar(calendarEl, {
    plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi, listPlugin, bootstrapPlugin ],
    // initialView: 'dayGridMonth',
    events: 'events.json',
    // 細かな設定
    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    firstDay: 0,
    themeSystem: '',
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

    dateClick: function(info){
      // 日付をクリックしたときのイベント
      // クリックした日付の情報を取得
      // const year = info.date.getFullYear();
      // const month = (info.date.getMonth() + 1);
      // const day = info.date.getDate();

      // ajaxでevents/newを着火させ、htmlを受け取る
      $.ajax({
        type: 'GET',
        url: 'events/new',
      }).done(function (res) {
        // 成功処理
        // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入
        $('#modal').html(res);
        
        // フォームの年、月、日を自動入力
        // $('#event_start_1i').val(year);
        // $('#event_start_2i').val(month);
        // $('#event_start_3i').val(day);
        
        // $('#event_end_li').val(day);
        // $('#event_end_2i').val(day);
        // $('#event_end_3i').val(day);
        
        // ここのidはevents/newのurlにアクセスするとhtmlがコードとして表示されるので、開始時間と終了時間のフォームをアワラしているところのidを確認してもらうことが確実
        
        let modal = document.getElementById('modal')
        let modalObj = new Modal(modal)
          modalObj.show();

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
  $('.error').click(function() {
    calendar.refetchEvents();
  });
});