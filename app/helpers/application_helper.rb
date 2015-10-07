module ApplicationHelper
  def nav_item(label, path)
    if path.blank?
      raw "<li>#{html label}</li>"
    else
      if request.path == path
        raw "<li class=\"active\"><a href=\"#{path}\">#{h label}</a></li>"
      else
        raw "<li><a href=\"#{path}\">#{h label}</a></li>"
      end
    end
  end
end
