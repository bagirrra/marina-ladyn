class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.text :info
      t.float :lat
      t.float :long
      t.string :locale

      t.timestamps
    end
  end


  def self.down
    drop_table :contacts
  end
end
