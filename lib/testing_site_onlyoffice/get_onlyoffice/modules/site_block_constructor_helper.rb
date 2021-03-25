# Helper methods for constructor block installers

module TestingSiteOnlyoffice
  module SiteBlockConstructorHelper
    def click_constructor_link(xpath)
      @instance.webdriver.get_element(xpath).click
    end

    def get_installer_release_date_or_version(release_date_xpath)
      date_text = @instance.webdriver.get_text(release_date_xpath)
      fetch_release_date_or_version(date_text)
    end

    def fetch_release_date_or_version(text)
      text.match(%r{\d+[./]\d+[./]\d+}).to_s
    end
  end
end
