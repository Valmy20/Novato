module ApplicationHelper
  def helper_status(status)
    if status
      content_tag(:span, 'Active', class: 'badge badge-pill badge-primary')
    else
      content_tag(:span, 'Inactive', class: 'badge badge-pill badge-danger')
    end
  end

  def helper_status_enum(model)
    if model.approved?
      content_tag(:span, 'Ativado', class: 'badge badge-pill badge-primary')
    else
      content_tag(:span, 'Desativado', class: 'badge badge-pill badge-danger')
    end
  end

  def logged_facebook(user)
    user.provider.blank?
  end

  def helper_month_post(month)
    case month
    when 1
      'Jan'
    when 2
      'Fev'
    when 3
      'Mar'
    when 4
      'Abr'
    when 5
      'Maio'
    when 6
      'Jun'
    when 7
      'Jul'
    when 8
      'Ago'
    when 9
      'Set'
    when 10
      'Out'
    when 11
      'Nov'
    else
      'Dez'
    end
  end
end
