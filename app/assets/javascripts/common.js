$(function() {
  var bind_all = function() {
    $(document).bind("keydown.h", "h", function() { help_modal(); });
    $(document).bind("keydown.a", "a", function() { add_modal(); });
    $(document).bind("keydown.right", "right", function() { next_page(); });
    $(document).bind("keydown.left", "left", function() { prev_page(); });
    $(document).bind("keydown.r", "r", function() { toggle_memorize(); });
    // toggle_memorize();
  }

  var help_modal = function() {
    $("div#help").modal({ show: true, keyboard: true, backdrop: true });
  }

  var add_modal = function() {
    $("div#add").modal({ show: true, keyboard: true, backdrop: true });
  }

  var next_page = function() {
    if ($("input#last_page").val() == "false") {
      var page = parseInt($("input#page").val());
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page + 1),
        success: function(data) {
          $("div#wordrobe").html(data);
        }
      });
    }
  }

  var prev_page = function() {
    if ($("input#first_page").val() == "false") {
      var page = parseInt($("input#page").val());
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page - 1),
        success: function(data) {
          $("div#wordrobe").html(data);
        }
      });
    }
  }

  var toggle_memorize = function() {
    
  }

  // bind event to help modal
  $("div#help").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function() {
      bind_all();
    }
  });

  // bind event to add modal
  $("div#add").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function () {
      bind_all();
    }
  });

  // bind event to add form input
  $("input#word").bind(
    "keydown", "return", function() {
      return false;
    }
  );

  // when help link clicked
  $("a#help_link").click(function() {
    help_modal();
    return false;
  });

  // when add button clicked
  $("input#add_button").click(function() {
    $.ajax({
      type: "POST",
      url: "/accounts/wordrobes",
      data: $("#add_form").serialize(),
      success: function(data) {
        $("input#word").val("");
        $("div#add").modal("hide");
        $("div#wordrobe").html(data);
      }
    });
  });

  bind_all();
});