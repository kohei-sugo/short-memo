class Memo < ApplicationRecord
  belongs_to :list, optional: true
  
  validates :list_id, presence: true
  validates :memotitle, presence: true
  validates :description, presence: true
  
  before_validation -> {
    if self.memotitle.blank? && self.description.blank?
      self.delete
    end
  }
  
  def require_validation?
    return true if memotitle.blank? && description.blank?
    false
  end
end
