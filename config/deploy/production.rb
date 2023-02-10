set :nginx_use_ssl, false
set :rails_env, "production"
set :puma_service_unit_name, :puma_rails_starter
set :puma_systemctl_user, :system

server "bandwagon", user: "starter", roles: %w[app db web]
