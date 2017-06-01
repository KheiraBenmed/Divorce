class ProceduresController < ApplicationController
   before_action :set_procedure, only: [:new, :create]

  def new

  end

  def create
    @procedure = Procedure.new(procedure_params)
    if
      @procedure.save
      redirect_to
    else
      render :new
    end
  end

  def edit
  end


  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy
    redirect_to
  end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:first_name , :last_name, :child_nb, :status_pro, :bank_account_nb, :status_pro_conjoint, :marriage_contract)
  end
end
