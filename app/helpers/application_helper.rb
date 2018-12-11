module ApplicationHelper
  def helper_status(status)
    if status
      content_tag(:span, 'Active', class: 'badge badge-pill badge-primary')
    else
      content_tag(:span, 'Inactive', class: 'badge badge-pill badge-danger')
    end
  end
end
