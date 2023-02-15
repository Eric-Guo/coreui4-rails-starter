set :application, "pp_vendor"
set :repo_url, "https://git.thape.com.cn/rails/performance.git"
set :nginx_use_ssl, true
set :rails_env, "production"
set :puma_service_unit_name, :puma_pp_vendor
set :puma_systemctl_user, :system

server "thape_vendor", user: "pp_vendor", roles: %w[app db web]
