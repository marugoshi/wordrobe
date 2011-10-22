# -*- coding: utf-8 -*-
module ApplicationHelper
  # usage: <%= parent_layout "application" %>
  def parent_layout(layout)
    @_content_for[:layout] = self.output_buffer
    self.output_buffer = render(:file => "layouts/#{layout}")
  end
end
