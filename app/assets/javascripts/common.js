$(function() {
  var bind_defalut_hotkeys = function() {
    $(document).bind("keydown.h", "h", function() { help_modal(); });
    $(document).bind("keydown.a", "a", function() { add_modal(); });
    $(document).bind("keydown.right", "right", function() { next_page(); });
    $(document).bind("keydown.left", "left", function() { prev_page(); });
    $(document).bind("keydown.r", "r", function() { toggle_memorize(); });
    $(document).bind("keydown.t", "t", function() { toggle_translate(); });
    // $(document).bind("keydown.p", "p", function() { history_modal(); });
    // $(document).bind("keydown.c", "c", function() { config_modal(); });
    $(document).bind("keydown.l", "l", function() { log_out(); });
  }

  var bind_history_hotkeys = function() {
    // $(document).bind("keydown.right", "right", function() { next_month(); });
    // $(document).bind("keydown.left", "left", function() { prev_month(); });
  }

  var help_modal = function() {
    $("div#help").modal({ show: true, keyboard: true, backdrop: true });
  }

  var add_modal = function() {
    $("div#add").modal({ show: true, keyboard: true, backdrop: true });
  }

  var switch_wordrobe = function(data) {
    $("div#heart").fadeOut("slow", function() {
      $("div#wordrobe").html(data);
      $("div#heart").hide().fadeIn("slow");
    });
  }

  var next_page = function() {
    if ($("input#last_page").val() == "false") {
      var page = parseInt($("input#page").val());
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page + 1),
        success: function(data) {
          switch_wordrobe(data);
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
          switch_wordrobe(data);
        }
      });
    }
  }

  var toggle_memorize = function() {
    if ($("input#wordrobe_id").val()) {
      var page = parseInt($("input#page").val());
      $.ajax({
        type: "PUT",
        url: "/accounts/wordrobes/" + $("input#wordrobe_id").val() + "/toggle_memorize?page=" + page,
        success: function(data) {
          switch_wordrobe(data);
        }
      });
    }
  }

  var toggle_translate = function() {
    if ($("input#wordrobe_id").val()) {
      var page = parseInt($("input#page").val());
      var translated = $("input#translated").val();
      $.ajax({
        type: "PUT",
        url: "/accounts/wordrobes/" + $("input#wordrobe_id").val() + "/toggle_translate?page=" + page + "&translated=" + translated,
        success: function(data) {
          switch_wordrobe(data);
        }
      });
    }    
  }

  var log_out = function() {
    $.ajax({
      type: "DELETE",
      url: "/log_out",
      success: function() {
        window.location.href = "/";
      }
    });
  }

  // bind event to help modal
  $("div#help").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function() {
      bind_defalut_hotkeys();
    }
  });

  // bind event to add modal
  $("div#add").bind({
    shown: function() {
      $(document).unbind("keydown");
    },
    hidden: function () {
      $("input#word").val("");
      bind_defalut_hotkeys();
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

  bind_defalut_hotkeys();
});
