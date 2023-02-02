# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-suite.aspx
  # https://user-images.githubusercontent.com/38238032/200776135-b199c1ad-2fa1-44fd-915c-ce256f4fe7ac.png
  class SiteFeaturesDocsOverview
    include PageObject

    div(:youtube_video, xpath: '//div[contains(@class, "ct_new_video")]')


    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(youtube_video_element) }
    end
  end
end
