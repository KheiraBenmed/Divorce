# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

   def extension_white_list
    %w(pdf doc htm html docx)
  end

end
