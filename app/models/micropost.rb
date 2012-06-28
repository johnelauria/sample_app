class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  def feed
  	# This is preliminary
  	Micropost.where("user_id = ?", id)
  end
end
