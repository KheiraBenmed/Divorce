class AvocatMailer < ApplicationMailer
  def procedure_send(procedure, avocat)
    @procedure = procedure
    @avocat = avocat
    mail(to: @avocat.email, subject: "Demande de rendez-vous pour procédure divorce")
  end
end

