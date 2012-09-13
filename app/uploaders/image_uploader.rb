class ImageUploader < CarrierWave::Uploader::Base
  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end
  storage :fog

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
