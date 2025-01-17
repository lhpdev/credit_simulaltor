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

  def calculate_age(birthdate)
    today = Date.today
    age = today.year - birthdate.year
    age -= 1 if today < birthdate + age.years
    age
  end
end
