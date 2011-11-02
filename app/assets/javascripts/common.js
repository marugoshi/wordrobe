// update wordrobe
$(function() {
  $(".update_wordrobe")
    .live("ajax:success", function(event, data, xhr) {
      $("#wordrobe").html(data);
    });
});
