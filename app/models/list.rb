class List < ApplicationRecord
  belongs_to :user
  
  has_many :memos, dependent: :destroy
  accepts_nested_attributes_for :memos, allow_destroy: true
  
  validates :title, presence: true, length: { maximum: 255 }
end
