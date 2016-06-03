require 'mongodb_logger/capistrano'
set :mongodb_logger_assets_dir, "public/assets" # where to put mongodb assets
after 'deploy:update_code', 'mongodb_logger:precompile'
class Deploy
end