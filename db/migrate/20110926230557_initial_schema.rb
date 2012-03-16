class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :platform
      t.string :tools
    end

    create_table :records do |t|
      t.string :user_id
      t.string :timename
      t.string :project
      t.string :activity
      t.string :timework
      t.string :month
      t.string :date
      t.string :year
    end
    
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :position
      t.string :login
      t.string :password
    end
  end  
  
  def self.down
    drop_table :projects
    drop_table :records
    drop_table :users
  end
end
