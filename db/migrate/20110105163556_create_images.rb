class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.string :file_ext
      t.integer :order
      t.references :collection

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
