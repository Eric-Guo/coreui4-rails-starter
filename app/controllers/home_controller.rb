class HomeController < ApplicationController
  def root
    set_meta_tags title: t(".title")
  end
end
