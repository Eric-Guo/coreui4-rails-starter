module ApplicationHelper
  include Pagy::Frontend

  def svg_icon(cil_name, icon_class, options = {})
    options["xlink:href"] = asset_path(cil_name)
    content_tag :svg, nil, class: icon_class do
      content_tag :use, nil, options
    end
  end

  def footer
    content_tag :footer, nil, class: "footer" do
      left_part = content_tag :div, nil do
        concat link_to "CoreUI", "https://coreui.io"
        concat " "
        concat link_to "Rails Starter Template", "https://git.thape.com.cn/Eric-Guo/coreui-pro-rails-starter"
        concat "  © 2023 Eric-Guo."
      end
      right_part = content_tag :div, nil, class: "ms-auto" do
        concat "Powered by "
        concat link_to "CoreUI PRO UI Components", "https://coreui-doc.redwoodjs.cn/"
      end
      left_part.concat(right_part)
    end
  end
end
