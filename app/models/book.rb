class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_one_attached :profile_image

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200 }

  def self.search_for(pattern,word)
    if pattern == 'perfect'
      Book.where(title: word)
    elsif pattern == 'forward'
      Book.where('title LIKE ?', word + '%')
    elsif pattern == 'backward'
      Book.where('title LIKE ?', '%' + word )
    else
      Book.where('title LIKE ?', '%' + word + '%')
    end
  end

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

end