class ProceduresController < ApplicationController
   before_action :set_procedure, only: [:new, :update, :edit, :show]

  def new
  end

  def show
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

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:first_name, :last_name, :child_nb, :status_pro, :bank_account_nb, :status_pro_conjoint, :marriage_contract, :passport,
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


