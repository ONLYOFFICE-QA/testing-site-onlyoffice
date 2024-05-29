# frozen_string_literal: true

shared_examples_for 'pricing_buy_page' do |project, support_levels, number_of_users|
  support_levels.each do |support_level|
    number_of_users.each do |number_connection|
      if (project == 'PricingDocsEnterprise') || (support_level == 'Basic')
        it "[Site][Pricing][#{project}] Choose the #{project} tariff: #{support_level}, count users: #{number_connection}" do
          pricing_page.fill_data_pricing_page(support_level, number_connection:)
          total_price = pricing_page.total_price_number.to_i
          payment_page = pricing_page.go_to_payment_from_pricing_page(pricing_page.buy_now_button_element, test_purchase: true)
          expect(payment_page.total_amount_without_tax).to eq(total_price)
        end
      else
        it "[Site][Pricing][#{project}] Choose the #{project} tariff: #{support_level}, count users: #{number_connection}" do
          pricing_page.fill_data_pricing_page(support_level, number_connection:)
          expect(pricing_page.total_price_upon_request).to eq('Upon request')
          expect(pricing_page).to be_button_get_quote_present
        end
      end
    end
  end
end
