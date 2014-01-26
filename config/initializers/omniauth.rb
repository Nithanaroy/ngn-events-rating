Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem' 
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :identifier => 'https://openid.intuit.com/openid/xrds'
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_VALUE']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_VALUE']
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_VALUE'], 
  {
      :name => "google",
      :scope => "userinfo.email, userinfo.profile, plus.me",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}