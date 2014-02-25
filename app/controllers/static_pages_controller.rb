class StaticPagesController < ApplicationController
	
	def welcome
		@coming_up = Event.order(from: :desc).limit(5) # First event in the Jumbotron
		@coming_up = @coming_up.where('created_at > ?', Time.now) if Rails.env.production?  # in dev show everything
		@recently_added = Event.order(created_at: :desc).limit(4)
	end

	def about
  	end

end
