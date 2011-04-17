class Comment < ActiveRecord::Base
  validates_presence_of :text
  before_save :set_defaults
  
  belongs_to :image
  
  def set_defaults
    self.author = I18n.t("comments.guest") if author.empty?
  end
end
