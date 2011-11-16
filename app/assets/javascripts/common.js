function bind_all() {
  $(document).bind("keydown.h", "h", help_modal);
  $(document).bind("keydown.a", "a", add_modal);
  next_page();
  previous_page();
}

function help_modal() {
  $("#help").modal({ show: true, keyboard: true, backdrop: true });
}
function add_modal() {
  $("#add").modal({ show: true, keyboard: true, backdrop: true });
}

function next_page() {
  $(document).unbind("keydown.right");
  if ($("#last_page").val() == "false") {
    $(document).bind("keydown.right", "right", function() {
      var page = parseInt($("#page").val());
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page + 1),
        success: function(data) {
          $("div#wordrobe").html(data);
        }
      });
    });
  }
}

function previous_page() {
  $(document).unbind("keydown.left");
  if ($("#first_page").val() == "false") {
    $(document).bind("keydown.left", "left", function() {
      var page = parseInt($("#page").val());
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page - 1),
        success: function(data) {
          $("div#wordrobe").html(data);
        }
      });
    });
  }
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

  $("#word").bind(
    "keydown", "return", function() {
      return false;
    }
  );
  $("#add_button").click(function() {
    $.ajax({
      type: "POST",
      url: "/accounts/wordrobes",
      data: $("#add_form").serialize(),
      success: function(data) {
        $("#word").val("");
        $("#add").modal("hide");
        $("div#wordrobe").html(data);
      }
    });
  });

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