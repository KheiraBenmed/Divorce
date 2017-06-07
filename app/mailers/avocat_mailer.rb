class AvocatMailer < ApplicationMailer
  def procedure_send(procedure, avocat)
    date = Date.today
    @procedure = procedure
    @avocat = avocat
    attachments["#{date.strftime('%m_%d_%Y')}_Dossier_Divorce.zip"] = open(@procedure.archive.url).read
    mail(to: @avocat.email, subject: "Demande de rendez-vous pour procédure divorce")
  end
end

