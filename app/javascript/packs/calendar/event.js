import { Calendar } from '@fullcalendar/core';
import monthGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import googleCalendarApi from "@fullcalendar/google-calendar";
import bootstrap5Plugin from '@fullcalendar/bootstrap5';
import 'bootstrap-icons/font/bootstrap-icons.css';
import '@fullcalendar/common/main.css';
import '@fullcalendar/daygrid/main.css';
import { Modal } from 'bootstrap/dist/js/bootstrap.esm.min.js';

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

    dateClick: function(info){
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
  $(function(){
    $(document).on('click', '#fetch', function(){
      calendar.refetchEvents();
    });
  });
});