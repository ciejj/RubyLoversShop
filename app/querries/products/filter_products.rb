# frozen_string_literal: true

module Products
  class FilterProducts
    def initialize(scope = Product.all.with_attached_main_image)
      @scope = scope
    end

    def call(params)
      @scope = filter_by_brand(params[:brand_id])
      @scope = filter_by_category(params[:category_id])
      filter_by_price_ranges(params[:price_range_ids])
    end

    private

    def filter_by_brand(brand_id)
      brand_id ? @scope.where(brand_id: brand_id) : @scope
    end

    def filter_by_category(category_id)
      category_id ? @scope.where(category_id: category_id) : @scope
    end

    def filter_by_price_ranges(price_range_ids)
      if price_range_ids
        price_ranges = price_range_ids.map { |id| PriceRange.find(id).range }
        @scope.where(price: price_ranges)
      else
        @scope
      end
    end
  end
end
