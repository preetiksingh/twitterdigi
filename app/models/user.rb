class User < ActiveRecord::Base
	has_many :tweets, dependent: :destroy
	def self.find_or_create_from_auth_hash(auth_hash)
		user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
		user.update(
			name: auth_hash.info.name,
			profile_image: auth_hash.info.image,
			token: auth_hash.credentials.token,
			secret: auth_hash.credentials.secret
			)
		user
	end

	def twitter
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["TWITTER_API_KEY"]
			config.consumer_secret     = ENV["TWITTER_API_SECRET"]
			config.access_token        = token
			config.access_token_secret = secret
		end
	end
end
