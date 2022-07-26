# frozen_string_literal: true

require_relative '../../additional_products/payment/avangate'
require_relative '../../additional_products/payment/stripe_payment_page'

module TestingSiteOnlyoffice
  # Helper methods for pricing pages
  module SitePricingHelper
    def go_to_avangate_from_pricing_page(buy_element, test_purchase: false)
      buy_element.click
      if test_purchase
        return StripePaymentPage.new(@instance) if @instance.webdriver.get_url.include?('stripe.com')

        Avangate.new(@instance)
        @instance.webdriver.open("#{@instance.webdriver.get_url}&DOTEST=1")
      end
      Avangate.new(@instance)
    end
  end
end
