class User < ActiveRecord::Base
	has_many :authorization
	has_many :ratings, class_name: 'EventsRatings', foreign_key: 'user_id', dependent: :delete_all

	def self.find_or_create_from_hash!(hash)
		# puts hash.to_yaml # for debugging
		# puts "Step 3"
		user_details = {
			:name => nil,
			:email => nil,
			:first_name => nil,
			:last_name => nil,
			:image_url => nil,
			:gender => nil
		}
		if hash['provider'].to_s == 'twitter'
			user_details[:email] = hash['extra']['raw_info']['email']
			user_details[:name] = hash['info']['name']
			user = User.where(:name => user_details[:name]).first if user_details[:name]
		elsif hash['provider'].to_s == 'open_id'
			puts 'CAME TO OPEN ID'
			user_details[:email] = hash['info']['email']
			user_details[:name] = hash['info']['name'] || user_details[:email]
			user = User.where(:email => user_details[:email]).first if user_details[:email]
		elsif hash['provider'].to_s == 'google'
			user_details[:email] = hash['info']['email']
			user_details[:name] = hash['info']['name']
			user_details[:first_name] = hash['info']['first_name']
			user_details[:last_name] = hash['info']['last_name']
			user_details[:image_url] = hash['info']['image']
			user_details[:gender] = hash['extra']['raw_info']['gender']
			user = User.where(:email => user_details[:email]).first
		end
		user = create(user_details) unless user
		user
	end

	def going?(event_id)
		rating = self.ratings.select { |r| r.event_id == event_id }.first
		rating.going if rating
	end
end
