module NavigationHelper
  def nav_item(link_text, link_path, cil_name = nil, html_options = {})
    nav_link_class = if current_page?(link_path)
      "nav-link active"
    else
      "nav-link"
    end
    content_tag :li, nil, class: "nav-item" do
      nav_class = html_options[:nav_class]
      html_option = html_options.except("nav_class")
      link_to link_path, {class: nav_link_class}, html_option do
        if cil_name.nil?
          concat content_tag :span, nil, class: "nav-icon"
        else
          concat content_tag :svg, content_tag(:use, nil, "xlink:href": asset_path(cil_name)), class: ["nav-icon", nav_class]
        end
        concat link_text
        concat capture { yield } if block_given?
      end
    end
  end
end
