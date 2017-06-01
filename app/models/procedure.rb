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

  mount_uploader :passport, DocumentUploader
  mount_uploader :passport_spouse, DocumentUploader
  mount_uploader :passport_children, DocumentUploader
  mount_uploader :identity, DocumentUploader
  mount_uploader :identity_spouse, DocumentUploader
  mount_uploader :identity_children, DocumentUploader
  mount_uploader :acte_naissance, DocumentUploader
  mount_uploader :acte_naissance_spouse, DocumentUploader
  mount_uploader :acte_naissance_children, DocumentUploader
  mount_uploader :livret, DocumentUploader
  mount_uploader :acte_mariage, DocumentUploader
  mount_uploader :contract_mariage, DocumentUploader
  mount_uploader :taxe_habitation, DocumentUploader
  mount_uploader :taxe_fonciere, DocumentUploader
  mount_uploader :rent, DocumentUploader
  mount_uploader :bills, DocumentUploader
  mount_uploader :insurance_vehicle, DocumentUploader
  mount_uploader :life_insurance, DocumentUploader
  mount_uploader :insurance_other, DocumentUploader
  mount_uploader :scolarite, DocumentUploader
  mount_uploader :caf, DocumentUploader
  mount_uploader :payroll, DocumentUploader
  mount_uploader :payroll_spouse, DocumentUploader
  mount_uploader :payroll_dec, DocumentUploader
  mount_uploader :payroll_spouse_dec, DocumentUploader
  mount_uploader :bilan_company, DocumentUploader
  mount_uploader :unemployment, DocumentUploader
  mount_uploader :unemployment_spouse, DocumentUploader
  mount_uploader :pro_revenu, DocumentUploader
  mount_uploader :pro_revenu_spouse, DocumentUploader
  mount_uploader :taxes, DocumentUploader
  mount_uploader :taxes_spouse, DocumentUploader
  mount_uploader :property, DocumentUploader
  mount_uploader :revenu_foncier, DocumentUploader
  mount_uploader :bank_account, DocumentUploader
  mount_uploader :carte_grise, DocumentUploader
end
