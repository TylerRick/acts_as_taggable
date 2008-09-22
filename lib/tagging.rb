class Tagging < ActiveRecord::Base #:nodoc:
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  validates_uniqueness_of :tag_id, :scope => [:taggable_type, :taggable_id], :message => 'The object has already has already been tagged with that tag'
  
  def after_destroy
    if Tag.destroy_unused
      if tag.taggings.count.zero?
        tag.destroy
      end
    end
  end
end
