class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: book.user_id)
  end
end