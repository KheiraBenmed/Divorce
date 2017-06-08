class ContactsController < ApplicationController

    def create
    @avocat = Avocat.find(params[:avocat_id])
    @procedure = current_user.procedure
    @contact = Contact.new(user: current_user, avocat: @avocat, procedure: @procedure)

    if @contact.save
      ZipJob.perform_later(@procedure.id)
      flash[:notice] = "Votre demande a été envoyée."
    else
      flash[:alert] = "Votre demande n'a pu être envoyée."
    end
    # pdf = WickedPdf.new.pdf_from_string(
    #   render_to_string('avocat_mailer/procedure_send', layout: false)
    # )
    # save_path = Rails.root.join('filename.pdf')
    # File.open(save_path, 'wb') do |file|
    #   file << pdf
    # end
    redirect_to  root_path
  end
end
