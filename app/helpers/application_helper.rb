module ApplicationHelper
  # Bootstrap Helpers...
  def bootstrap_panel(title=nil)
    title_html = unless title.blank?
      content_tag(:div, class: 'panel-heading') do
        content_tag(:h3, class: 'panel-title') do
          title
        end
      end
    else
      ''.html_safe
    end

    body_html = content_tag(:div, class: 'panel-body') do
      yield
    end

    content_tag(:div, class: 'panel panel-default') do
      title_html + body_html
    end
  end

  def show_icon
    '<span class="glyphicon glyphicon-search glyphicon-padded"></span>'.html_safe
  end

  def edit_icon
    '<span class="glyphicon glyphicon-edit glyphicon-padded"></span>'.html_safe
  end

  def destroy_icon
    '<span class="glyphicon glyphicon-trash glyphicon-padded"></span>'.html_safe
  end

  def remove_icon
    '<span class="glyphicon glyphicon-remove"></span>'.html_safe
  end

  def flash_name_to_bootstrap_alert(name)
    case name.to_s
    when 'notice'
      'success'
    when 'error'
      'danger'
    else
      'info'
    end
  end

  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end
end
