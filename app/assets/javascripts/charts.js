function testAjax() {
  $.get("/logs.json", function(data) {
    alert(data);
  });
}
