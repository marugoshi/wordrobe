function bind_all() {
  $(document).bind(
    "keydown", "h", function() {
      $("#help").modal({ show: true, keyboard: true, backdrop: true })
    }
  );
  $(document).bind(
    "keydown", "a", function() {
      $("#add").modal({ show: true, keyboard: true, backdrop: true })
    }
  );
}

$(function() {
  $("#help").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function() {
      bind_all();
    }
  });

  $("#add").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function () {
      bind_all();
    }
  });

  $("#add_button").click(function() {
    $.post(
      "/accounts/wordrobes",
      $("#add_form").serialize()
    )
    .success(function(data) {
      $("#word").val("");
      $("#add").modal("hide");
      $("div#wordrobe").html(data);
    });
  });
  $("#word").bind(
    "keydown", "return", function() {
      return false;
    }
  );

  /*
  $(".update_wordrobe").live(
    "ajax:success",
    function(event, data, xhr) {
      $("div#wordrobe").html(data);
    }
  );
  */

  bind_all();
});