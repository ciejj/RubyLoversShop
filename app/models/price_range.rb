# frozen_string_literal: true

class PriceRange < ApplicationRecord
  def name
    if min.zero?
      "Under $#{max}"
    elsif max == Float::INFINITY
      "$#{min} & Above"
    else
      "$#{min} to $#{max}"
    end
  end

  def range
    min..max
  end
end
