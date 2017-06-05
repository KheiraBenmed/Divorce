procedure = Procedure.first
document_names = [:passport, :passport_spouse]

archive_file = Tempfile.new('archive.zip')

Zip::File.open(archive_file.path, Zip::File::CREATE) do |zip_file|
  document_names.each do |document_name|
    document = procedure.send(document_name)
    next if document.blank?

    data = open(document.url)
    zip_file.get_output_stream("#{document_name}.pdf") { |f| f.write(data.read) }
  end
end

procedure.update(archive: File.open(archive_file.path))

# ajouter un attachement archive sur la table procédure
# une fois que la procédure crée l'archive est générée et enregistré dans la procédure
# quand on ajoute un document ça regénère l'archive
