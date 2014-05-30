module HttpBasicAuthorization
  # This module patches the default authentication system
  # by using HTTP Basic Authorization headers fields to login
  # users or create them if necessary.
  module ApplicationControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :try_to_autologin, :http_basic
      end
    end

    module InstanceMethods
      # We hijack the autologin method as this the HTTP Basic authorization
      # is a kind of auto login system which created users on the fly.
      def try_to_autologin_with_http_basic
        if http_authorization?
          authenticate_with_http_basic do |username, _password|
            logger.info "Successful authentication for '#{username}'" \
              "from #{request.remote_ip} at #{Time.now.utc}"
            self.logged_user = User.find_by_login(username) ||
                               create_http_authorization_user(username)
          end
        else
          try_to_autologin_without_http_basic
        end
      end

      private

      def http_authorization?
        request.authorization.present?
      end

      def create_http_authorization_user(username)
        email = "#{username}@neopoly.de"
        user = User.new(mail: email, firstname: username, lastname: username)
        user.login = username
        user.save!
      end
    end
  end

  # This module overwrites the default behavior of the AccountController
  # by disabling most of its methods as they make no sense in combination
  # with the implicit user generation used by this plugin
  module AccountControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :login, :http_basic
        alias_method_chain :logout, :http_basic
        alias_method_chain :lost_password, :http_basic
        alias_method_chain :register, :http_basic
        alias_method_chain :activate, :http_basic
        alias_method_chain :activation_email, :http_basic
      end
    end

    module InstanceMethods
      def login_with_http_basic
        not_available!
      end

      # If the user was fully logged in only present a simple text
      # stating to logout by closing the browser
      def logout_with_http_basic
        if User.current.anonymous?
          redirect_to home_url
        elsif request.post?
          render text: "You session is now over, please " \
            "<a href=\"javascript:window.open('', '_self', '');" \
            "window.close();\">close your browser</a>"
        end
      end

      def lost_password_with_http_basic
        not_available!
      end

      def register_with_http_basic
        not_available!
      end

      def activate_with_http_basic
        not_available!
      end

      def activation_email_with_http_basic
        not_available!
      end

      private

      def not_available!
        render text: "Method Not Allowed", status: 405
      end
    end
  end
end
