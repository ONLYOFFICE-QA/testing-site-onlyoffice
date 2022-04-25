# frozen_string_literal: true

module TestingSiteOnlyoffice
  # parent class for integrators
  class SiteIntegration
    include PageObject
    attr_accessor :connector_type

    element(:title, xpath: '//div[@class="ct_head"]/span')

    def initialize(instance, connector_type)
      super(instance.webdriver.driver)
      @instance = instance
      @connector_type = connector_type
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(title_element) }
      @instance.webdriver.wait_until { @instance.webdriver.get_text(title_element) == @connector_type }
    end

    def check_link_pick_your_price
      @instance.webdriver.click_on_locator('//div[@class="cfb_block cf_enterprises"]//a[contains(@href,"docs-enterprise-prices.aspx")]', true)
      SitePriceDocsEnterprise.new(@instance)
    end

    def check_link_home_tariff
      @instance.webdriver.click_on_locator('//div[@class="cfb_block cf_home"]//a[contains(@href,"/docs-enterprise-prices.aspx")]', true)
      SitePriceDocsEnterprise.new(@instance)
    end

    def check_link_for_integration?(section)
      attribute = @instance.webdriver.get_attribute(move_to_link_integration[section][:element], 'href')
      @instance.webdriver.click_on_locator(move_to_link_integration[section][:element], true)
      @instance.webdriver.switch_to_popup
      return true if section == :nextcloud_app_store || parse_url.include?('apple.com/us/app/onlyoffice-documents/')

      attribute.include?(parse_url)
    end

    def parse_url
      current_url = URI(@instance.webdriver.get_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def move_to_link_integration
      {
        nextcloud_apps_store: {
          element: '//div[@class="seven_reasons"]//a[contains(@href,"https://apps.nextcloud.com/apps/onlyoffice")]'
        },
        integration_git_hub: {
          element: '//a[contains(@href,"https://github.com/ONLYOFFICE/DocumentServer")]'
        },
        integration_app_store: {
          element: '//a[contains(@href,"https://itunes.apple.com/us/app")]'
        },
        integration_google_play: {
          element: '//a[contains(@href,"https://play.google.com/store/apps")]'
        }
      }
    end
  end
end
