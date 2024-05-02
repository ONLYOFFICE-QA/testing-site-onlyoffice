# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /hosting-providers.aspx
  # https://user-images.githubusercontent.com/38238032/197181815-4744c402-62a8-4504-abc2-48d4a6a356b8.png
  class SitePartnersWebHosting
    include PageObject
    include SiteToolbar
    include SiteDownloadHelper

    link(:docs_enterprise_link, xpath: '//a[@id = "linkid_docs_ee"]')
    link(:feedback_on_forum, xpath: '//a[contains(@href, "/forum.onlyoffice") and contains(@class, "link")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(docs_enterprise_link_element)
      end
    end

    def click_feedback_on_forum
      feedback_on_forum_element.click
      SiteAboutForum.new(@instance)
    end

    def get_hosting_product_link(provider, id)
      xpath = "(//div[contains(@class, 'provider_#{provider}')]//a[@id='#{id}'])[1]"
      @instance.webdriver.get_attribute(xpath, 'href')
    end
  end
end
