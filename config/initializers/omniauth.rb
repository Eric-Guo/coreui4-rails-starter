OmniAuth.config.request_validation_phase do |env|
  Gitlab::RequestForgeryProtection.call(env)
end

Rails.application.config.middleware.use OmniAuth::Builder do
  issuer = if Rails.env.development?
    "https://sso-id.com"
  else
    "https://sso.thape.com.cn"
  end

  redirect_uri = if Rails.env.development?
    "https://rails-starter.test/auth/openid_connect/callback"
  else
    "https://performance.thape.com.cn/auth/openid_connect/callback"
  end

  provider :openid_connect,
    name: :openid_connect,
    scope: %i[openid email],
    response_type: :code,
    uid_field: "email",
    issuer: issuer,
    discovery: true,
    client_options: {
      identifier: Rails.application.credentials.openid_connect_identifier,
      secret: Rails.application.credentials.openid_connect_secret,
      redirect_uri: redirect_uri
    }
end
