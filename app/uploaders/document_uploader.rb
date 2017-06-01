# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
