module ApplicationHelper
  def helper_status(status)
    if status
      content_tag(:span, 'Active', class: 'badge badge-pill badge-primary', style: 'padding: 7px')
    else
      content_tag(:span, 'Inactive', class: 'badge badge-pill badge-danger', style: 'padding: 7px')
    end
  end

  def helper_status_enum(model)
    if model.approved?
      content_tag(:span, 'Ativado', class: 'badge badge-pill badge-primary', style: 'padding: 7px')
    else
      content_tag(:span, 'Desativado', class: 'badge badge-pill badge-danger', style: 'padding: 7px')
    end
  end

  def helper_status_publication(model)
    if model.approved?
      content_tag(:span, 'Aprovado', class: 'badge badge-pill badge-success', style: 'padding: 7px')
    elsif model.disapproved?
      content_tag(:span, 'Desaprovado', class: 'badge badge-pill badge-danger', style: 'padding: 7px')
    else
      content_tag(:span, 'Review', class: 'badge badge-pill badge-info', style: 'padding: 7px')
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

  def who_create_post(type, id)
    if type == 'Collaborator'
      row = Collaborator.find_by(id: id)
      row.name
    elsif type == 'Institution'
      row = Institution.find_by(id: id)
      row.name
    end
  end

  def user_compete?(publication)
    return false if current_user.blank?

    compete = Compete.find_by(user_id: current_user.id, publication_id: publication)
    compete.present?
  end
end
