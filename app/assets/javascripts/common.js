$(function() {
  var bind_defalut_hotkeys = function() {
    $(document).bind("keydown.h", "h", function() { help_modal(); });
    $(document).bind("keydown.a", "a", function() { add_modal(); });
    $(document).bind("keydown.right", "right", function() { next_page(); });
    $(document).bind("keydown.left", "left", function() { prev_page(); });
    $(document).bind("keydown.Shift+right", "Shift+right", function() { next_page(10); });
    $(document).bind("keydown.Shift+left", "Shift+left", function() { prev_page(10); });
    $(document).bind("keydown.m", "m", function() { toggle_memorize(); });
    $(document).bind("keydown.up", "up", function() { toggle_translate(); });
    // $(document).bind("keydown.p", "p", function() { history_modal(); });
    // $(document).bind("keydown.c", "c", function() { config_modal(); });
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

  var error_modal = function() {
    $("div#error").modal({ show: true, keyboard: true, backdrop: true });
  }

  var privacy_modal = function() {
    $("div#privacy").modal({ show: true, keyboard: true, backdrop: true });
  }

  var switch_wordrobe = function(data) {
    $("div#heart").fadeOut("slow", function() {
      $("div#wordrobe").html(data);
      if ($("input#error").val()) {
        error_modal();
      }
      $("div#heart").hide().fadeIn("slow");
    });
  }

  var next_page = function(add_pages) {
    if ($("input#last_page").val() == "false") {
      var page = parseInt($("input#page").val());
      if (add_pages) {
        page += add_pages;
      }
      $.ajax({
        type: "GET",
        url: "/accounts/wordrobes/wordrobes?page=" + (page + 1),
        success: function(data) {
          switch_wordrobe(data);
        }
      });
    }
  }

  var prev_page = function(minus_pages) {
    if ($("input#first_page").val() == "false") {
      var page = parseInt($("input#page").val());
      if (minus_pages) {
        page -= minus_pages;
      }
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

  // bind event to error modal
  $("div#error").bind({
    shown: function() {
      $(document).unbind("keydown");
      $("div#error p#message").text($("input#error").val());
    },
    hidden: function () {
      bind_defalut_hotkeys();
    }
  });

  // bind event to add form input
  $("input#word").bind(
    "keydown", "return", function() {
      return false;
    }
  );

  $("a#privacy_link").click(function() {
    privacy_modal();
    return false;
  });

  $("a#help_link").click(function() {
    help_modal();
    return false;
  });

  $("a#withdraw_link").click(function() {
    $.ajax({
      type: "DELETE",
      url: "/accounts",
      success: function() {
        window.location.href = "/";
      }
    });
  });

  // when add button clicked
  $("input#add_button").click(function() {
    var word = $("input#word").val();
    $.ajax({
      type: "POST",
      url: "/accounts/wordrobes?word=" + word,
      success: function(data) {
        $("input#word").val("");
        $("div#add").modal("hide");
        $("div#wordrobe").html(data);

        if ($("input#error").val()) {
          error_modal();
        }
      }
    });
  });

  bind_defalut_hotkeys();
});
