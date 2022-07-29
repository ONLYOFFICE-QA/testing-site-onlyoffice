# frozen_string_literal: true

require_relative '../../additional_products/payment/avangate'
require_relative '../../additional_products/payment/stripe_payment_page'

module TestingSiteOnlyoffice
  # Helper methods for pricing pages
  module SitePricingHelper
    def go_to_avangate_from_pricing_page(buy_element, test_purchase: false)
      buy_element.click
      wait_pricing_on_production
      if test_purchase
        return StripePaymentPage.new(@instance) if @instance.webdriver.get_url.include?('stripe.com')

        Avangate.new(@instance)
        @instance.webdriver.open("#{@instance.webdriver.get_url}&DOTEST=1")
      end
      Avangate.new(@instance)
    end

    # For some reason loading stripe page on production server
    # require several redirects and them not very fast, so we need to wait
    # @return [nil]
    def wait_pricing_on_production
      return unless config.server.include?('.com')

      sleep 5
    end
  end
end
