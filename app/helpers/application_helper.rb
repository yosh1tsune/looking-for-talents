module ApplicationHelper
  def toastr_flash
    flash_messages = ''

    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      type = 'info'    if type == 'info'
      text = "toastr.#{type}('#{message}');"
      flash_messages << text.html_safe if message
    end

    '<script>$(document).ready(function() '\
    "{ #{flash_messages} });</script>".html_safe
  end
end
