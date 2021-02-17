require_relative '../../additional_products/payment/avangate'

module TestingSiteOnlyoffice
  module SitePricingHelper
    def go_to_avangate_from_pricing_page(buy_element, test_purchase = false)
      buy_element.click
      if test_purchase
        Avangate.new(@instance)
        @instance.webdriver.open("#{@instance.webdriver.get_url}&DOTEST=1")
      end
      Avangate.new(@instance)
    end
  end
end
