module UsersHelper
  def full_name
    check_name(user.first_name) + " " + check_name(user.last_name)
  end

  def age
    ((Time.zone.now - user.birth_date.to_time) / 1.year.seconds).floor
  end

  private

  def check_name(name)
    name.present? ? name.capitalize : "Не задано"
  end
end
