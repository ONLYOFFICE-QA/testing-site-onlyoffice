# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /awards.aspx
  # https://user-images.githubusercontent.com/67409742/145370157-70ba81ce-e5cd-4efc-a0d1-6b3c6f29a4f6.png
  class SiteAwards
    include PageObject

    div(:awards_page, xpath: '//body[@id="awardspage"]')
    link(:awards_page, xpath: '//div[@class="mp_gto_button"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { awards_page_element.present? }
    end

    def click_use_cloud
      @instance.webdriver.wait_until { awards_page_element.present? }
      awards_page_element.click
      SiteSignUp.new(@instance)
    end
  end
end
