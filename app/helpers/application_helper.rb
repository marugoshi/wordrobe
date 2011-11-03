# -*- coding: utf-8 -*-
module ApplicationHelper
  def greeting
    hour = Time.now.strftime("%H").to_i
    return t("message.good_evening") if hour >= 0 && hour < 4
    return t("message.good_morning") if hour >= 4 &&  hour < 10
    return t("message.good_afternoon") if hour >= 10 && hour < 18
    return t("message.good_evening") if hour >= 18 && hour < 24
  end
end
