class ThumbUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    resize_to_limit(500, 500)
  end

  version :thumb do
    process :crop
    resize_to_fill(300, 220)
  end

  version :tiny do
    process :crop
    resize_to_fill(50, 50)
  end

  def crop
    return nil if model.crop_x.blank?

    resize_to_limit(500, 500)
    manipulate! do |img|
      x = model.crop_x.to_i
      y = model.crop_y.to_i
      w = model.crop_w.to_i
      h = model.crop_h.to_i
      img.crop([[w, h].join('x'), [x, y].join('+')].join('+'))
    end
  end
end
