# frozen_string_literal: true

# Payment page for Stripe
# https://user-images.githubusercontent.com/668524/181003109-5116123b-0a62-4369-86e4-66261da2c1f8.png
class StripePaymentPage
  attr_accessor :instance

  def initialize(instance)
    @instance = instance
    @xpath_submit_button = '//div[contains(@class,"SubmitButton-IconContainer")]'
    wait_to_load
  end

  # Wait until page is loaded
  def wait_to_load
    @instance.webdriver.wait_until do
      @instance.webdriver.element_visible?(@xpath_submit_button)
    end
  end

  # Submit order for notification
  def submit_order_for_notification(params = {})
    @instance.webdriver.type_to_locator('//*[@id="email"]', params[:email], true, true)
    @instance.webdriver.type_to_locator('//*[@id="cardNumber"]', '4242424242424242', true, true)
    @instance.webdriver.type_to_locator('//*[@id="cardExpiry"]', '1250', true, true)
    @instance.webdriver.type_to_locator('//*[@id="cardCvc"]', '111', true, true)
    @instance.webdriver.type_to_locator('//*[@id="billingName"]', 'Teamlab Ruby', true, true)

    @instance.webdriver.click_on_locator(@xpath_submit_button)
    wait_for_order_finish
  end

  # After order is finished - there is redirect to site main page
  def wait_for_order_finish
    @instance.webdriver.wait_until do
      @instance.webdriver.get_url.include?('onlyoffice.com')
    end
  end
end
