class MongodbLoggerHelper
  def self.logger(user = nil)
    current_user = user ? user : { username: 'guest'}
    if Rails.logger.respond_to?(:add_metadata)
      Rails.logger.add_metadata({ :username => current_user[:username]})
    end
  end
end