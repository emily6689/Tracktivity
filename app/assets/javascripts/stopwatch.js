function stopWatch(clockIn) {
      if (!clockIn || !clockIn.length) {
        return setClock(00, 00, 00)
      }
      var now = new Date()
      var start = new Date(clockIn);
      var difference = moment.utc(moment(now,"DD/MM/YYYY HH:mm:ss").diff(moment(start,"DD/MM/YYYY HH:mm:ss")));
      setClock(difference.get('hour'), difference.get('minute'), difference.get('second'));
    }

      function setClock(hours, minutes, seconds) {
        $('.hours').text('0'+ hours);
        $('.minutes').text('0' + minutes);
        $('.seconds').text('0' + seconds);
      }

    function startTimer(){
      timer = setInterval(function(){
        var seconds = Number($('.seconds').text());
        var minutes = Number($('.minutes').text());
        var hours = Number($('.hours').text());
        seconds++;
        if (seconds > 59){
          seconds = 0;
          minutes++;
        }
        if (minutes > 59){
          minutes = 0;
          hours++;
        }
        if (seconds < 10) {
          seconds = '0' + seconds;
        }
        if (minutes < 10) {
          minutes = '0' + minutes;
        }
        if (hours < 10){
          hours = '0' + hours;
        }
        var seconds = $('.seconds').text(seconds);
        var minutes = $('.minutes').text(minutes);
        var hours = $('.hours').text(hours);
      }, 1000)
    }

    function stopTimer(){
      clearInterval(timer);
    }
