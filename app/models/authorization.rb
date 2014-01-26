class Authorization < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider

	def self.find_from_hash(hash)
		find_by_provider_and_uid(hash['provider'], hash['uid'])
	end

	def self.create_from_hash(hash, user = nil)
		puts "Steps 2 \n\n USER #{user.to_yaml}"
		user = User.find_or_create_from_hash!(hash) unless user
		Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
	end
end
