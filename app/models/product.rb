class Product < ApplicationRecord
  has_one_attached :main_image
  belongs_to :category
  scope :filter_by_category, -> (category_id) { where category_id: category_id }

  def main_image_path
    main_image.attached? ? main_image : 'http://placehold.it/700x400'
  end
end
