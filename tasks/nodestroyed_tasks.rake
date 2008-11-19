namespace :nodestroyed do
  desc "Check Model"
  task :check => :environment do
    puts models_need_add_destroyed
  end
  
  desc "Generate migration"
  task :migration => :environment do
    models_need_add_destroyed.each do |model|
      
    end
  end
  
  
  private
  def models_need_add_destroyed
    Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }
    models_need_add_destroyed = Array.new
    Object.subclasses_of(ActiveRecord::Base).each do |model|
      next if model.to_s == "CGI::Session::ActiveRecordStore::Session"
      models_need_add_destroyed << model unless model.new.respond_to? :destroyed
    end
    models_need_add_destroyed
  end
end