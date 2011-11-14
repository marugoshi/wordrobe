function bind_all() {
  $(document).bind("keydown", "h", toggle_help_modal);
  $(document).bind("keydown", "a", toggle_add_modal);
}

function toggle_help_modal() {
  $("#help").modal({ show: true, keyboard: true, backdrop: true })
}

function toggle_add_modal() {
  $("#add").modal({ show: true, keyboard: true, backdrop: true })
}
