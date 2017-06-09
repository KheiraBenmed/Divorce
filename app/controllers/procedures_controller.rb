class ProceduresController < ApplicationController
   before_action :set_procedure, only: [:new, :update, :edit, :show]

  def show
    calcul_champs_non_remplis
    calcul_doc_uploadés
    calcul_doc_a_uploader
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
    if params[:passport_children_from_camera].present?
      @procedure.passport_children = convert_data_uri_to_upload(params[:passport_children_from_camera])
    end
    if params[:identity_from_camera].present?
      @procedure.identity = convert_data_uri_to_upload(params[:identity_from_camera])
    end
    if params[:identity_spouse_from_camera].present?
      @procedure.identity_spouse = convert_data_uri_to_upload(params[:identity_spouse_from_camera])
    end
    if params[:identity_children_from_camera].present?
      @procedure.identity_children = convert_data_uri_to_upload(params[:identity_children_from_camera])
    end
    if params[:acte_naissance_from_camera].present?
      @procedure.acte_naissance = convert_data_uri_to_upload(params[:acte_naissance_from_camera])
    end
    if params[:acte_naissance_spouse_from_camera].present?
      @procedure.acte_naissance_spouse = convert_data_uri_to_upload(params[:acte_naissance_spouse_from_camera])
    end
    if params[:livret_from_camera].present?
      @procedure.livret = convert_data_uri_to_upload(params[:livret_from_camera])
    end
    if params[:acte_mariage_from_camera].present?
      @procedure.acte_mariage = convert_data_uri_to_upload(params[:acte_mariage_from_camera])
    end
    if params[:contract_mariage_from_camera].present?
      @procedure.contract_mariage = convert_data_uri_to_upload(params[:contract_mariage_from_camera])
    end
    if params[:payroll_from_camera].present?
      @procedure.payroll = convert_data_uri_to_upload(params[:payroll_from_camera])
    end
    if params[:payroll_dec_from_camera].present?
      @procedure.payroll_dec = convert_data_uri_to_upload(params[:payroll_dec_from_camera])
    end
    if params[:pro_revenu_spouse_from_camera].present?
      @procedure.pro_revenu_spouse = convert_data_uri_to_upload(params[:pro_revenu_spouse_from_camera])
    end
    if params[:bank_account_from_camera].present?
      @procedure.bank_account = convert_data_uri_to_upload(params[:bank_account_from_camera])
    end
    if params[:taxes_from_camera].present?
      @procedure.taxes = convert_data_uri_to_upload(params[:taxes_from_camera])
    end
    if params[:taxes_spouse_from_camera].present?
      @procedure.taxes_spouse = convert_data_uri_to_upload(params[:taxes_spouse_from_camera])
    end
    if params[:taxe_habitation_from_camera].present?
      @procedure.taxe_habitation = convert_data_uri_to_upload(params[:taxe_habitation_from_camera])
    end
    if params[:rent_from_camera].present?
      @procedure.rent = convert_data_uri_to_upload(params[:rent_from_camera])
    end
    if params[:bills_from_camera].present?
      @procedure.bills = convert_data_uri_to_upload(params[:bills_from_camera])
    end
    if params[:insurance_other_from_camera].present?
      @procedure.insurance_other = convert_data_uri_to_upload(params[:insurance_other_from_camera])
    end


    @procedure.update(procedure_params)
    #ZipJob.perform_later(@procedure.id)

    respond_to do |format|
      format.html { redirect_to procedure_path(@procedure) }
      format.js
    end
  end

  def zipcreate
    date = Date.today
    @procedure = Procedure.find(params[:procedure_id])
    ProcedureToArchiveService.new(@procedure).call
    zip_data = open(@procedure.archive.url).read
    filename = "#{date.strftime('%m_%d_%Y')}_Dossier_Divorce.zip"
    send_data(zip_data, type: 'application/zip', filename: filename )
    # redirect_to procedure_path(@procedure)
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

  def calcul_doc_uploadés
    @doc_upload = 0
    if !current_user.procedure[:passport].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:passport_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:passport_children].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:identity].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:identity_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:identity_children].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:acte_naissance].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:acte_naissance_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:acte_naissance_children].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:livret].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:acte_mariage].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:contract_mariage].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:taxe_habitation].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:taxe_fonciere].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:rent].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:bills].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:insurance_vehicle].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:insurance_other].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:scolarite].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:caf].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:payroll].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:payroll_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:payroll_dec].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:payroll_spouse_dec].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:bilan_company].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:unemployment].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:unemployment_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:pro_revenu].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:pro_revenu_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:taxes].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:taxes_spouse].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:property].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:revenu_foncier].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:bank_account].nil?
      @doc_upload += 1
    end
    if !current_user.procedure[:carte_grise].nil?
      @doc_upload += 1
    end
    return @doc_upload
  end

  def calcul_doc_a_uploader
    @doc = 1
    if !@procedure.full_name.nil?
      @doc += 11
    end
    if !@procedure.vehicle_nb.nil?
      if @procedure.vehicle_nb > 0
        @doc += 1
      end
    end
    if !@procedure.renter_nb.nil?
      if @procedure.renter_nb > 0
        @doc += 2
      end
    end

    if !@procedure.insurance_nb.nil?
      @doc += 1
    end

    if !@procedure.bank_account_nb.nil?
      if @procedure.bank_account_nb > 0
        @doc += 1
      end
    end

    if !@procedure.status_pro.nil?
      if @procedure.status_pro == "Salarié"
        @doc += 2
      end
    end
    if !@procedure.status_pro_conjoint.nil?
      if @procedure.status_pro_conjoint == "Libéral"
        @doc += 1
      end
    end
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
