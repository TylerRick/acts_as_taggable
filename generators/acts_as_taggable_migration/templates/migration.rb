class ActsAsTaggableMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end
    
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.timestamps
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]

    # Prevent the same object (taggable_id, taggable_type) from being tagged with the same tag (tag_id) multiple times.
    add_index :taggings, [:taggable_id, :taggable_type, :tag_id], :unique => true
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
