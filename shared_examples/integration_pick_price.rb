# frozen_string_literal: true

shared_examples_for 'integration_pick_price' do
  it 'Go to pick your price' do
    business_price = @integration.check_link_pick_your_price
    expect(business_price.check_active_tariff?('business')).to be true
  end

  it 'Go to home tariff' do
    business_price = @integration.check_link_home_tariff
    expect(business_price.check_active_tariff?('home')).to be true
  end
end
