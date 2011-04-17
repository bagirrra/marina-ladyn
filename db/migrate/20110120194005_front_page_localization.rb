class FrontPageLocalization < ActiveRecord::Migration
  def self.up
    rename_column :front_pages, :header, :header_en
    rename_column :front_pages, :footer, :footer_en
    add_column :front_pages, :header_ru, :text
    add_column :front_pages, :header_de, :text
    add_column :front_pages, :footer_ru, :text
    add_column :front_pages, :footer_de, :text  
  end

  def self.down
    remove_column :front_pages, :footer_de
    remove_column :front_pages, :footer_ru
    remove_column :front_pages, :header_de
    remove_column :front_pages, :header_ru
    rename_column :front_pages, :footer_en, :footer
    rename_column :front_pages, :header_en, :header
  end
end
