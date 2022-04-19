# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-nextcloud.aspx
  # https://user-images.githubusercontent.com/67409742/163774909-8621c72c-9762-4a22-8fd0-d29dff5fd10b.png
  class SiteNextcloud
    include PageObject

    element(:title_nextcloud, xpath: '//div[@class="ct_head"]/span')
    link(:get_it_now, xpath: '//div[@class="connector_top"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]')
    link(:get_onlyoffice_now, xpath: '//div[@id="goonbtn"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(title_nextcloud_element) }
      return true if name_title == 'Nextcloud'
    end

    def name_title
      @instance.webdriver.get_text(title_nextcloud_element)
    end

    def check_link_get_it_now
      get_it_now_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def check_link_download_for_desktop
      @instance.webdriver.click_on_locator('//a[contains(@href,"/apps.aspx")]', true)
      SiteProductsDesktop.new(@instance)
    end

    def check_link_get_onlyoffice_now
      @instance.webdriver.click_on_locator('//div[@id="goonbtn"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]', true)
      SiteDocsEnterprise.new(@instance)
    end

    def check_link_pick_your_price
      @instance.webdriver.click_on_locator('//div[@class="cfb_block cf_enterprises"]//a[contains(@href,"docs-enterprise-prices.aspx")]', true)
      SitePriceDocsEnterprise.new(@instance)
    end

    def check_link_home_tariff
      @instance.webdriver.click_on_locator('//div[@class="cfb_block cf_home"]//a[contains(@href,"/docs-enterprise-prices.aspx")]', true)
      SitePriceDocsEnterprise.new(@instance)
    end

    def check_link_for_nextcloud?(section)
      attribute = @instance.webdriver.get_attribute(move_to_link_nextcloud[section][:element], 'href')
      @instance.webdriver.click_on_locator(move_to_link_nextcloud[section][:element], true)
      @instance.webdriver.switch_to_popup
      return true if section == :nextcloud_app_store || parse_url.include?('apple.com/us/app/onlyoffice-documents/')

      attribute.include?(parse_url)
    end

    def parse_url
      current_url = URI(@instance.webdriver.get_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def move_to_link_nextcloud
      {
        nextcloud_apps_store: {
          element: '//div[@class="seven_reasons"]//a[contains(@href,"https://apps.nextcloud.com/apps/onlyoffice")]'
        },
        nextcloud_git_hub: {
          element: '//a[contains(@href,"https://github.com/ONLYOFFICE/DocumentServer")]'
        },
        nextcloud_app_store: {
          element: '//a[contains(@href,"https://itunes.apple.com/us/app")]'
        },
        nextcloud_google_play: {
          element: '//a[contains(@href,"https://play.google.com/store/apps")]'
        }
      }
    end
  end
end
