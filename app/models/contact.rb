class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :avocat
  belongs_to :procedure

  after_create :send_email

  private

  def send_email
    AvocatMailer.procedure_send(procedure, avocat).deliver_now
  end

end
