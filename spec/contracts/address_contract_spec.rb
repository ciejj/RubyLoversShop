# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressContract do
  let(:result) { subject.call(attributes) }

  context 'when all attributes are present' do
    let(:attributes) { attributes_for(:address) }

    it 'is valid' do
      expect(result).to be_success
    end
  end

  context 'when street_name_1 is missing' do
    let(:attributes) { attributes_for(:address, street_name1: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing street_name_1' do
      expect(result.errors[:street_name1]).to eq(['must be filled'])
    end
  end

  context 'when street_name_2 is missing' do
    let(:attributes) { attributes_for(:address, street_name2: '') }

    it 'is valid' do
      expect(result).to be_success
    end
  end

  context 'when city is missing' do
    let(:attributes) { attributes_for(:address, city: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing city' do
      expect(result.errors[:city]).to eq(['must be filled'])
    end
  end

  context 'when country is missing' do
    let(:attributes) { attributes_for(:address, country: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing contry' do
      expect(result.errors[:country]).to eq(['must be filled'])
    end
  end

  context 'when state is missing' do
    let(:attributes) { attributes_for(:address, state: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing state' do
      expect(result.errors[:state]).to eq(['must be filled'])
    end
  end

  context 'when zip code is missing' do
    let(:attributes) { attributes_for(:address, zip: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing zip code' do
      expect(result.errors[:zip]).to eq(['must be filled'])
    end
  end

  context 'when phone is missing' do
    let(:attributes) { attributes_for(:address, phone: '') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about missing phone' do
      expect(result.errors[:phone]).to eq(['must be filled'])
    end
  end

  context 'when phone is in incorrect format' do
    let(:attributes) { attributes_for(:address, phone: '600200800') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs about incorrect format' do
      expect(result.errors[:phone]).to eq(['phone number must be in a XXX XXX XXX format'])
    end
  end

  context 'when zip code is in incorrect format' do
    let(:attributes) { attributes_for(:address, zip: '12345') }

    it 'is invalid' do
      expect(result).to be_failure
    end

    it 'informs aboput incorrect format' do
      expect(result.errors[:zip]).to eq(['zip code must be in XX-XXX format'])
    end
  end
end
