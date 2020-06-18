module ApplicationHelper
  def toastr_flash
    flash_messages = ''

    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      type = 'info'    if type == 'info'
      text = "toastr.#{type}(`#{message}`);"
      flash_messages << text if message
    end

    content_tag(:script, "$(document).ready(function() { #{flash_messages} });")
  end
end
