class Article < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def favorite_user(user_id)
    favorites.find_by(user_id: user_id)
  end
end
