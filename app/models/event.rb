class Event < ActiveRecord::Base
  before_destroy :delete_image

  validates :name, presence: {:message => ': can\'t be blank'}
  validates :place, presence: {:message => ': can\'t be blank'}
  validates :from, presence: {:message => ': can\'t be blank'}
  validates :to, presence: {:message => ': can\'t be blank'}

  def initialize(params=nil)
    super(params)
    # Make it a whole day event by default
    self.from = Date.today
    self.to = Date.today + 1.day - 1.second
  end

  has_many :ratings, class_name: 'EventsRatings', foreign_key: 'event_id', dependent: :delete_all

  #def rating
  #  ratings = self.ratings.map { |r| r.rating }
  #  return -1 if ratings.count == 0 # Has not been rated yet
  #  (ratings.sum / Float(ratings.size)).round(1)
  #end

  def delete_image
    begin
      File.delete(GlobalConstants::EVENT_IMAGES_PATH.join(self.id.to_s))
    rescue Exception
      # TODO Log these errors
    end
  end

  def image_url
    absolute_path = Rails.public_path.join('event_images', self.id.to_s)
    filename = '/event_images/' + self.id.to_s
    return filename if File.exists? absolute_path and File.file? absolute_path
    nil
  end
end
