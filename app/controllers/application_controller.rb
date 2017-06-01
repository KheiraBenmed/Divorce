class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resources)
    if !current_user.procedure
      @procedure = Procedure.new
      @procedure.user = current_user
      @procedure.save(validate: false)
    end
     edit_procedure_path(current_user.procedure)
  end
end
