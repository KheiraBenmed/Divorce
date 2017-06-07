class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :avocat
  belongs_to :procedure

end
