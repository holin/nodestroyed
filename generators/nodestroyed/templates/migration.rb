class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    <%
      tables.each do |table|
    %>
    add_column :<%= table%>, :destroyed, :boolean, :default => false
    add_index :<%= table%>, [:destroyed]
    <%    
      end
    %>
  end

  def self.down
    <%
      tables.each do |table|
    %>
    remove_column :<%= table%>, :destroyed, :boolean, :default => false
    remove_index :<%= table%>, [:destroyed]
    <%    
      end
    %>
  end
end
