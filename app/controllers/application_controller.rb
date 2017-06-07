class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
  end

  def after_sign_in_path_for(resources)
    if !current_user.procedure
      @procedure = Procedure.new
      @procedure.user = current_user
      @procedure.save(validate: false)
    end
     edit_procedure_path(current_user.procedure)
  end

  # Split up a data uri
  def split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1 # "image/gif"
      uri[:encoder] = $2 # "base64"
      uri[:data] = $3 # data string
      uri[:extension] = $1.split('/')[1] # "gif"
      return uri
    else
      return nil
    end
  end

# Convert data uri to uploaded file. Expects object hash, eg: params[:post]
  def convert_data_uri_to_upload(data_uri)
    if !data_uri.blank?
      image_data = split_base64(data_uri)
      image_data_string = image_data[:data]
      image_data_binary = Base64.decode64(image_data_string)

      temp_img_file = Tempfile.new("data_uri-upload")
      temp_img_file.binmode
      temp_img_file << image_data_binary
      temp_img_file.rewind

      img_params = {:filename => "data-uri-img.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
      uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

      return uploaded_file
    end

    return nil
  end
end
