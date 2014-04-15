<% content_for :extra_footer do %>
  <script>
    $(function(){
      $('.clock').on('ajax:success', function(event, response){
        $link = $(event.target);
        $link.hide();
        if ($link.text() === 'Clock In'){
                  debugger;
          $link.text('Clock Out');
        } else {
          $link.text('Clock In');
        }
        $link.fadeIn();
      });
    });
  </script>
<% end %>
