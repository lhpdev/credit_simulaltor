module ApplicationHelper
  def flash_class(type)
    case type
    when "notice" then "flash-notice"
    when "alert" then "flash-alert"
    when "success" then "flash-success"
    when "error" then "flash-error"
    else "flash-info"
    end
  end
end
