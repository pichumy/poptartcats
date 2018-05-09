class Session < ApplicationRecord
  validates :user_id, :ip_address, :session_token, presence: true

  belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  def self.delete(user_id, session_token)
    session = Session.find_by(user_id: user_id, session_token: session_token)
    session.destroy!
  end
end
