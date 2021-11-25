# frozen_string_literal: true

class AddressContract < Dry::Validation::Contract
  params do
    required(:street_name_1).filled(:string)
    optional(:street_name_1).filled(:string)
    required(:city).filled(:string)
    required(:city).filled(:string)
    required(:country).filled(:string)
    required(:state).filled(:string)
    required(:zip).filled(:string)
    required(:phone).filled(:string)
  end

  rule(:phone) do
    key.failure('phone number must be in a XXX XXX XXX format') unless value =~ /\A\d{3} \d{3} \d{3}\z/
  end

  rule(:zip) do
    key.failure('zip code must be in XX-XXX format') unless value =~ /\A\d{2}-\d{3}\z/
  end
end
