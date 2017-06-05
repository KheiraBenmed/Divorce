class ProceduresController < ApplicationController
   before_action :set_procedure, only: [:new, :update, :edit, :show]

  def show
    calcul_champs_non_remplis
  end

  def new
  end

  def create
    @procedure = Procedure.new(procedure_params)
    if
      @procedure.save
      redirect_to procedure_path(@procedure)
    else
      render :new
    end
  end

  def edit
    set_procedure
    @questions = Procedure::QUESTIONS
  end

  def update
    @procedure.update(procedure_params)
    redirect_to procedure_path(@procedure)
  end

  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy
    redirect_to root_path
  end

  def calcul_champs_non_remplis
    @champ_not_done = 0
    if current_user.procedure.child_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.owner_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.renter_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.status_pro == ""
      @champ_not_done += 1
    end
    if current_user.procedure.bank_account_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.credit_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.insurance_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.vehicle_nb.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.contract_type == ""
      @champ_not_done += 1
    end
    if current_user.procedure.status_pro_conjoint == ""
      @champ_not_done += 1
    end
    if current_user.procedure.marriage_contract.nil?
      @champ_not_done += 1
    end
    if current_user.procedure.full_name == ""
      @champ_not_done += 1
    end

    return @champ_not_done
  end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(
      :full_name,
      :child_nb,
      :owner_nb,
      :renter_nb,
      :status_pro,
      :bank_account_nb,
      :credit_nb,
      :insurance_nb,
      :vehicle_nb,
      :contract_type,
      :status_pro_conjoint,
      :marriage_contract,
      :passport,
      :passport_spouse,
      :passport_children,
      :identity,
      :identity_spouse,
      :identity_children,
      :acte_naissance,
      :acte_naissance_spouse,
      :acte_naissance_children,
       :livret,
       :acte_mariage,
       :contract_mariage,
       :taxe_habitation,
       :taxe_fonciere,
       :rent,
       :bills,
       :insurance_vehicle,
       :life_insurance,
       :insurance_other,
       :scolarite,
       :caf,
       :payroll,
       :payroll_spouse,
       :payroll_dec,
       :payroll_spouse_dec,
       :bilan_company,
       :unemployment,
       :unemployment_spouse,
       :pro_revenu,
       :pro_revenu_spouse,
       :taxes,
       :taxes_spouse,
       :property,
       :revenu_foncier,
       :bank_account,
       :carte_grise)
  end

end
