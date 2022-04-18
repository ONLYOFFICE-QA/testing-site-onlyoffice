# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-nextcloud.aspx
  # https://user-images.githubusercontent.com/67409742/163774909-8621c72c-9762-4a22-8fd0-d29dff5fd10b.png
  class SiteNextcloud
    include PageObject

    element(:title_nextcloud, xpath: '//div[@class="ct_head"]/span')
    link(:get_it_now, xpath: '//div[@class="connector_top"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]')
    link(:nextcloud_app_store, xpath: '//div[@class="seven_reasons"]//a[contains(@href,"https://apps.nextcloud.com/apps/onlyoffice")]')
    link(:nextcloud_git_hub, xpath: '//a[contains(@href,"https://github.com/ONLYOFFICE/DocumentServer")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(title_nextcloud_element) }
      name_title == 'Nextcloud'
    end

    def name_title
      @instance.webdriver.get_text(title_nextcloud_element)
    end

    def check_link_get_it_now
      get_it_now_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def check_link_for_nextcloud?(section)
      attribute = @instance.webdriver.get_attribute(move_to_link_nextcloud[section][:element], 'href')
      link = move_to_link_nextcloud[section][:element]
      link.click
      @instance.webdriver.switch_to_popup
      attribute.include?(parse_url)
    end

    def parse_url
      current_url = URI(@instance.webdriver.get_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def move_to_link_nextcloud
      {
        nextcloud_app_store: {
          element: nextcloud_app_store_element
        },
        nextcloud_git_hub: {
          element: nextcloud_git_hub_element
        }
      }
    end
  end
end
