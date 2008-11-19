require "#{RAILS_ROOT}/vendor/plugins/nodestroyed/lib/util.rb"
include Nodestroyed::Util
class NodestroyedGenerator < Rails::Generator::NamedBase
  attr_accessor :tables, :filename
  def manifest
    @file_name = 'all_needed_models'
    if name != 'ALL'
      specified_models = name.split(",")
      @tables = models_need_add_destroyed.select{|m| specified_models.include?(m.table_name)}
      @tables = @tables.map{|m| m.table_name}.uniq
      @file_name = @tables.join("_and_")
    end
    record do |m|
      m.migration_template 'migration.rb', "db/migrate", {:assigns => local_assigns,
        :migration_file_name => migration_name
      }
    end
  end

  private

  def local_assigns
    returning(assigns = {}) do
      assigns[:migration_name] = migration_name.camelize
      assigns[:tables] = @tables
    end
  end
  
  def migration_name
    "add_destroyed_field_to_#{@file_name}"
  end
end
