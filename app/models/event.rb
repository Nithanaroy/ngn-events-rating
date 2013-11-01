class Event < ActiveRecord::Base
  def initialize(params=nil)
    super(params)
    # Make it a whole day event by default
    self.from = Date.today
    self.to = Date.today + 1.day - 1.second
  end

  has_many :ratings, class_name: 'EventsRatings', foreign_key: 'event_id', dependent: :delete_all

  def rating
    ratings = self.ratings.map { |r| r.rating }
    return -1 if ratings.count == 0 # Has not been rated yet
    (ratings.sum / Float(ratings.size)).round(1)
  end
end
