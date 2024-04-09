class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # アソシエーションとフォロー中の人を取得（ソースは相手がフォローされている人から持ってきて自分のフォローしている人として表示）
  has_many :relationships, foreign_key: :following_id , dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  # アソシエーションとフォロワー取得（ソースは相手が自分をフォローしている人から持ってきて自分がフォローされている人として表示）
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :following

  has_one_attached :profile_image

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum: 50 }

  def get_profile_image
    (profile_image.attached?)? profile_image : 'no_image.jpg'
  end

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

  def followed_by?(user)
     followings.include?(user)
  end

end
