class SessionsController < ApplicationController

	def index
		@authentications = current_user.authorization if current_user
		# render :text => @authentications.to_json
	end

	def create
    	auth = request.env['omniauth.auth']
		unless @auth = Authorization.find_from_hash(auth)
			# puts "Step 1 HASH #{auth.to_yaml}"
			# Create a new user or add an auth to existing user, depending on
			# whether there is already a user signed in.
			@auth = Authorization.create_from_hash(auth, current_user)
		end
		# Log the authorizing user in.
		self.current_user = @auth.user

		# render :text => "Welcome, #{current_user.name}."
		redirect_to events_url
  	end

  	def destroy
  		@authentication = current_user.authorization.destroy_all
  		session.delete(:user_id)
  		puts "Came to #{current_user.authorization.inspect}"
  		flash[:notice] = "Logged out!"
		redirect_to :controller => 'events', :action => 'index'
  	end

  	def failure
  		flash[:notice] = "Login failed!"
  		flash[:type] = "danger"
		redirect_to :controller => 'events', :action => 'index'
  	end
end
