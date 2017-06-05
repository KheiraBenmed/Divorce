class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :procedure

  after_create :send_email_avocat

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
