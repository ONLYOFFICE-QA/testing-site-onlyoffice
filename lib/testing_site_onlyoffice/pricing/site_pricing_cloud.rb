# /saas.aspx
# https://user-images.githubusercontent.com/40513035/102266177-257ba000-3f29-11eb-9745-e0a798e94ba7.png
require_relative '../additional_products/site_faq'

module TestingSiteOnlyffice
  class SitePricingCloud
    include PageObject
    include SiteToolbar

    link(:start_free_trial_link, xpath: '*//div[@class="start-trial-block"]//a[contains(@href,"registration")]')
    element(:faq_pricing_questions_link, xpath: '(//*[contains(@class,"faq_pricing_block")]//b)[last()]')
    link(:faq_center_link, xpath: '//a[contains(@href,"faq/faq") and not(@target)]')
    link(:tariff_20_year_link, xpath: '(//*[@id="tariff20"]//a)[2]')
    div(:cost_tariff_20_year, xpath: '(//*[@id="tariff20"]//*[contains(@class,"price-block")])[3]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        start_free_trial_visible?
      end
    end

    def start_free_trial_visible?
      start_free_trial_link_element.present?
    end

    def click_on_faq_center
      unless faq_center_link_element.present?
        faq_pricing_questions_link_element.click
        sleep 1 # wait for extend animation
      end
      faq_center_link_element.click
      SiteFaq.new(@instance)
    end

    def click_on_buy_now
      tariff_20_year_link
      Avangate.new(@instance)
    end

    def click_start_free_trial
      start_free_trial_link
      SiteSignUp.new(@instance)
    end

    def get_cost_tarrif_20_year
      price = @instance.webdriver.get_text(cost_tariff_20_year_element.selector[:xpath])
      price.sub @instance.webdriver.get_text("#{cost_tariff_20_year_element.selector[:xpath]}/span"), ''
    end
  end
end
