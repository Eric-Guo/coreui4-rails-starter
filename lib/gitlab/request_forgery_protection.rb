# A module to check CSRF tokens in requests.
# It's used in API helpers and OmniAuth.
# Usage: GitLab::RequestForgeryProtection.call(env)

module Gitlab
  module RequestForgeryProtection
    # rubocop:disable Rails/ApplicationController
    class Controller < ActionController::Base
      protect_from_forgery with: :exception, prepend: true

      def initialize
        super

        # Squelch noisy and unnecessary "Can't verify CSRF token authenticity." messages.
        # X-Csrf-Token is only one authentication mechanism for API helpers.
        self.logger = ActiveSupport::Logger.new(File::NULL)
      end

      def index
        head :ok
      end
    end

    def self.app
      @app ||= Controller.action(:index)
    end

    def self.call(env)
      app.call(env)
    end

    def self.verified?(env)
      minimal_env = env.slice("REQUEST_METHOD", "rack.session", "HTTP_X_CSRF_TOKEN")
        .merge("rack.input" => "")
      call(minimal_env)

      true
    rescue ActionController::InvalidAuthenticityToken
      false
    end
    # rubocop:enable Rails/ApplicationController
  end
end
