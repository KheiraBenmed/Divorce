class ProceduresController < ApplicationController
   before_action :set_procedure, only: [:new, :update, :edit, :show]

  def show
    calcul_champs_non_remplis
    calcul_doc_non_uploadés
    @recap = @champ_not_done + @doc_not_upload
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
    @questions = Procedure::QUESTIONS
    if params[:file]
      @procedure.update!(procedure_params_for_files)
    else
      @procedure.update!(procedure_params)
    end

    if params[:passport_from_camera].present?
      @procedure.passport = convert_data_uri_to_upload(params[:passport_from_camera])
    end
    if params[:passport_spouse_from_camera].present?
      @procedure.passport_spouse = convert_data_uri_to_upload(params[:passport_spouse_from_camera])
    end
    if params[:identity_from_camera].present?
      @procedure.identity = convert_data_uri_to_upload(params[:identity_from_camera])
    end
    if params[:identity_spouse_from_camera].present?
      @procedure.identity_spouse = convert_data_uri_to_upload(params[:identity_spouse_from_camera])
    end

    @procedure.update(procedure_params)

    respond_to do |format|
      format.html { redirect_to procedure_path(@procedure) }
      format.js
    end
  end

  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy
    redirect_to root_path
  end

  def testcamera
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

  def calcul_doc_non_uploadés
    @doc_not_upload = 0
    if current_user.procedure[:passport].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:passport_spouse].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:passport_children].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:identity].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:identity_spouse].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:identity_children].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:acte_naissance].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:acte_naissance_spouse].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:acte_naissance_children].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:livret].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:acte_mariage].nil?
      @doc_not_upload += 1
    end
    if current_user.procedure[:contract_mariage].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:taxe_habitation].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:taxe_fonciere].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:rent].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:bills].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:insurance_vehicle].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:insurance_other].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:scolarite].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:caf].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:payroll].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:payroll_spouse].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:payroll_dec].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:payroll_spouse_dec].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:bilan_company].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:unemployment].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:unemployment_spouse].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:pro_revenu].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:pro_revenu_spouse].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:taxes].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:taxes_spouse].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:property].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:revenu_foncier].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:bank_account].nil?
      @doc_not_upload += 1
    end

    if current_user.procedure[:carte_grise].nil?
      @doc_not_upload += 1
    end

    return @doc_not_upload
  end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params_for_files
    params.permit(
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
       :carte_grise
    )
  end

  def procedure_params
    return {} unless params[:procedure]
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
