module ApplicationHelper
  def svg_icon(cil_name, icon_class)
    content_tag :svg, nil, class: icon_class do
      content_tag :use, nil, "xlink:href": asset_path(cil_name)
    end
  end
end
