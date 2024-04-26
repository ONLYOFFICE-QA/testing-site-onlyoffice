# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /hosting-providers.aspx
  # https://user-images.githubusercontent.com/38238032/197181815-4744c402-62a8-4504-abc2-48d4a6a356b8.png
  class SiteGetOnlyofficeWebHosting
    include PageObject
    include SiteToolbar

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
  end
end
