$(function() {
  $("div#header div#picture a[rel=twipsy]").twipsy({
    live: true,
    offset: 0,
    placement: 'below'
  })

  $("div#header div#link a[rel=twipsy]").twipsy({
    live: true,
    offset: 10,
    placement: 'below'
  })

  var bind_defalut_hotkeys = function() {
    $(document).bind("keydown.h", "h", function() { help_modal(); });
    $(document).bind("keydown.a", "a", function() { add_modal(); });
    $(document).bind("keydown.right", "right", function() { next_page(); });
    $(document).bind("keydown.left", "left", function() { prev_page(); });
    $(document).bind("keydown.r", "r", function() { toggle_memorize(); });
    $(document).bind("keydown.t", "t", function() { toggle_translate(); });
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
