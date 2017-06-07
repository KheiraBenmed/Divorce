class ZipJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    p "Running job"
    @procedure = Procedure.find(id)
    ProcedureToArchiveService.new(@procedure).call
    AvocatMailer.procedure_send(@procedure, @procedure.contacts.last.avocat).deliver_now
  end
end
