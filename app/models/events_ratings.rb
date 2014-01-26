class EventsRatings < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  def self.update_or_create_by_event_and_user(event, user, update_with=nil)
  	where(:event => event, :user => user).delete_all
  	create({:event => event, :user => user}.merge(update_with))
  end
end
