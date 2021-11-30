# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /blog/
  # https://user-images.githubusercontent.com/40513035/101406576-af54b900-38ea-11eb-942d-ec817bad65cf.png
  class SiteBlog
    include PageObject
    include SiteToolbar

    link(:article_blog, xpath: '(//*[contains(@id,"post-")]//a)[1]|//div[contains(@class, "postThemeGridBox")]//a')
    elements(:desktop_mobile_app, xpath: '//div[@class="download-button"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { article_blog_element.present? }
    end

    def desktop_and_mobile_app
      apps = desktop_mobile_app_elements.map { |app| app.attribute('class') }
      apps.map { |s| s.gsub('download ', '') }
    end
  end
end
