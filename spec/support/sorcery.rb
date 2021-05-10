# frozen_string_literal: true

module Sorcery
  module TestHelpers
    module Rails
      module Request
        def login_user_request(user = nil, password = '111111111', route = nil, http_method = :post)
          user ||= @user
          user.password = password
          user.password_confirmation = password
          user.save!
          user.activate!
          route ||= user_sessions_url

          username_attr = user.sorcery_config.username_attribute_names.first
          username = user.send(username_attr)
          password_attr = user.sorcery_config.password_attribute_name

          send(http_method, route, params: { "#{username_attr}": username, "#{password_attr}": password })
        end
      end
    end
  end
end
