class Procedure < ApplicationRecord
  belongs_to :user
  # GENDERS = ["Homme", "Femme"]
  # validates :gender, inclusion: { in: GENDERS }
  CHILDREN = [0..10]
  validates :child_nb, inclusion: { in: CHILDREN }
  STATUSES = ["Salarié", "Chef d'entreprise", "Sans Emploi", "Libéral"]
  validates :status_pro, inclusion: { in: STATUSES}
  BANKS = [1..10]
  validates :bank_account_nb, inclusion: { in: BANKS }
  validates :status_pro_conjoint, inclusion: { in: STATUSES }
  MARIAGES = ["Communauté de biens réduite aux acquêts", "Séparation de biens, participation aux acquêts", "communauté universelle", "Je ne sais pas" ]
  validates :marriage_contract, inclusion: { in: MARIAGES }
  # mount_uploader :passport, DocumentUploader
end
