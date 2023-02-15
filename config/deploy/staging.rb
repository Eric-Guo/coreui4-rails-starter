set :application, "rails_starter"
set :repo_url, "https://git.thape.com.cn/Eric-Guo/coreui-pro-rails-starter.git"
set :nginx_use_ssl, true
set :rails_env, "production"
set :puma_service_unit_name, :puma_rails_starter
set :puma_systemctl_user, :system

server "bandwagon", user: "starter", roles: %w[app db web]
