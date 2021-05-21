class Product < ApplicationRecord
  has_one_attached :main_image
  
  def main_image_path
    main_image.attached? ? main_image : 'http://placehold.it/700x400'
  end

end
