module GlobalConstants
  MAX_FILE_SIZE = 1 * 1024 * 1024 # 1MB - Used during image upload for an event
  GENERIC_ERROR_MSG = 'Something went wrong. We are working on it'
  EVENT_IMAGES_PATH = Rails.public_path.join('event_images')
end