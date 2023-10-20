# frozen_string_literal: true

require_relative '../get_onlyoffice/onlyoffice_workspace/site_get_onlyoffice_workspace_enterprise'
require_relative 'modules/site_pricing_helper'

module TestingSiteOnlyoffice
  # /workspace-prices.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/9ce399ca-d8fe-4a64-83b8-b71e4ffba9d2
  class SitePricingWorkSpace
    include PageObject
    include SitePricingHelper

    BASE_XPATH = '//div[@id ="pp_button_desktop"]'
    link(:try_free, xpath: '//a[contains(@href, "/download-workspace.aspx") and text() = "Try free for 30 days"]')
    link(:buy_button_basic, xpath: "#{BASE_XPATH}//a[@class = 'button gray basicBuyButton']")
    link(:buy_button_standard, xpath: "#{BASE_XPATH}//a[@class = 'button red standartBuyButton']")
    link(:buy_button_premium, xpath: "#{BASE_XPATH}//a[@class = 'button gray premiumBuyButton']")

    div(:add_user_num_basic, xpath: '//div[contains(@class,"pp_connections_increase simcon_change basicSelectors" )]')
    div(:add_user_num_standard, xpath: '//div[contains(@class,"pp_connections_increase simcon_change standartSelectors" )]')
    div(:add_user_num_premium, xpath: '//div[contains(@class,"pp_connections_increase simcon_change premiumSelectors" )]')

    div(:connections_number_basic, xpath: '//div[@id = "basic-users-value"]')
    div(:connections_number_standard, xpath: '//div[@id = "standart-users-value"]')
    div(:connections_number_premium, xpath: '//div[@id = "premium-users-value"]')

    span(:total_price_basic, xpath: '//div[@class = "pp_sum basicSum"]/span')
    span(:total_price_standard, xpath: '//div[@class = "pp_sum standartSum"]/span')
    span(:total_price_premium, xpath: '//div[@class = "pp_sum premiumSum"]/span')

    span(:total_price_upon_req_basic, xpath: '//div[@class = "pp_sum basicSum" and @data-value = "more"]/span')
    span(:total_price_upon_req_standard, xpath: '//div[@class = "pp_sum standartSum" and @data-value = "more"]/span')
    span(:total_price_upon_req_premium, xpath: '//div[@class = "pp_sum premiumSum" and @data-value = "more"]/span')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(try_free_element) }
    end

    def click_try_free
      try_free_element.click
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end

    def add_user_number(number, tariff)
      @instance.webdriver.click_on_locator(send("add_user_num_#{tariff}_element")) while number != connections_number(tariff)
    end

    def connections_number(tariff)
      @instance.webdriver.get_text(send("connections_number_#{tariff}_element"))
    end

    def buy_now_button(tariff)
      send("buy_button_#{tariff}_element")
    end

    def button_get_quote_present?(tariff)
      @instance.webdriver.get_text(buy_now_button(tariff)) == 'GET A QUOTE'
    end

    def total_price_sum(tariff)
      @instance.webdriver.get_text(send("total_price_#{tariff}_element"))
    end

    def total_price_upon_request(tariff)
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(send("total_price_upon_req_#{tariff}_element"))
      end
      @instance.webdriver.get_text(send("total_price_upon_req_#{tariff}_element"))
    end
  end
end
