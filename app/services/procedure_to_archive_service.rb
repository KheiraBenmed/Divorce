class ProcedureToArchiveService

  def initialize(procedure)
    @procedure = procedure
  end

  def call
    image_names = [:passport, :passport_spouse, :passport,:passport_spouse, :passport_children, :identity, :identity_spouse, :identity_children]
    pdf_names = [:acte_naissance, :acte_naissance_spouse, :acte_naissance_children, :livret, :acte_mariage, :contract_mariage, :taxe_habitation, :taxe_fonciere, :rent, :bills, :insurance_vehicle, :life_insurance, :insurance_other, :scolarite, :caf, :payroll, :payroll_spouse, :payroll_dec, :payroll_spouse_dec, :bilan_company, :unemployment, :unemployment_spouse, :pro_revenu, :pro_revenu_spouse, :taxes, :taxes_spouse, :property, :revenu_foncier, :bank_account, :carte_grise]
    document_names = image_names + pdf_names

    archive_file = Tempfile.new('archive.zip')

    Zip::File.open(archive_file.path, Zip::File::CREATE) do |zip_file|
      document_names.each do |document_name|
        document = @procedure.send(document_name)
        next if document.blank?

        data = open(document.url)
        filename = image_names.include?(document_name) ? "#{document_name}.jpg" : "#{document_name}.pdf"
        zip_file.get_output_stream(filename) { |f| f.write(data.read) }
      end
    end

    puts archive_file.path

    @procedure.update(archive: File.open(archive_file.path))
  end
end
