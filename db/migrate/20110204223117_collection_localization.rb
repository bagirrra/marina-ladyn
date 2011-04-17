class CollectionLocalization < ActiveRecord::Migration
  def self.up
    rename_column :collections, :name, :name_en
    add_column :collections, :name_ru, :text
    add_column :collections, :name_de, :text
  end

  def self.down
    remove_column  :collections, :name_de
    remove_column  :collections, :name_ru
    rename_column :collections, :name_en, :name
  end
end
