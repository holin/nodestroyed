require "#{RAILS_ROOT}/vendor/plugins/nodestroyed/lib/util.rb"
include Nodestroyed::Util
namespace :nodestroyed do
  desc "Check Model"
  task :check => :environment do
    puts models_need_add_destroyed
  end
end