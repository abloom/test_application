# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def home_link
    returning String.new do |str|
      str << tag(:br)
      str << link_to("Home", root_path)
    end
  end
end
