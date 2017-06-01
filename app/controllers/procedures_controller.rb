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

  # def calcul_champs_remplis
  #   champ_done = 0
  #   if current_user.procedure.child_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.owner_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.renter_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.status_pro.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.bank_account_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.credit_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.insurance_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.vehicle_nb.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.contract_type.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.status_pro_contact.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.marriage_contract.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.first_name.nil?
  #     champ_done =+ 1
  #   end
  #   if current_user.procedure.last_name.nil?
  #     champ_done =+ 1
  #   end
  # end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:first_name, :last_name, :child_nb, :status_pro, :bank_account_nb, :status_pro_conjoint, :marriage_contract)
  end
end
