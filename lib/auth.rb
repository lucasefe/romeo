require 'rack/oauth2'
require 'curl'
require 'cuba'
require 'cuba/safe'
require_relative 'helper'

class Auth < Cuba
  include Helper
  plugin Cuba::Safe

  define do
    on get do
      on root do
        session[:state] = SecureRandom.hex(16)
        authorization_uri = client.authorization_uri(
          state: session[:state],
          scope: ["user",  "user:email"],
          response_type: [:token, :access_token]
        )
        res.redirect authorization_uri
      end

      on 'complete', param(:code) do |code|
        client.authorization_code = code
        access_token = client.access_token!
        session[:access_token] = access_token.to_s
        res.redirect data_path
      end
    end
  end

  private

  def client
    @client ||= Rack::OAuth2::Client.new(
      identifier: ENV.fetch('GH_CLIENT_ID'),
      secret: ENV.fetch('GH_CLIENT_SECRET'),
      redirect_uri: 'http://192.168.99.103:3000/auth/complete',
      host: 'github.com',
      authorization_endpoint: '/login/oauth/authorize',
      token_endpoint: '/login/oauth/access_token'
    )
  end
end
