class AddGroupToCollection < ActiveRecord::Migration
  def self.up
    add_column :collections, :group, :string
  end

  def self.down
    remove_column :collections, :group
  end
end
