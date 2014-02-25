class StaticPagesController < ApplicationController
	
	def welcome
		@coming_up = Event.order(from: :desc).limit(5) # First event in the Jumbotron
		@recently_added = Event.order(created_at: :desc).limit(4)
	end

	def about
  	end

end
