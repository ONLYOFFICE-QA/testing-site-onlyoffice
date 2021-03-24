# Helper methods for constructor block installers

module TestingSiteOnlyoffice
  module SiteBlockConstructorHelper
    def click_constructor_link(xpath)
      @instance.webdriver.get_element(xpath).click
    end

    def get_installer_version(version_xpath)
      version_text = @instance.webdriver.get_text(version_xpath)
      get_release_date_or_version(version_text)
    end

    def get_installer_release_date(release_date_xpath)
      release_date_text = @instance.webdriver.get_text(release_date_xpath)
      get_release_date_or_version(release_date_text)
    end

    def get_release_date_or_version(text)
      text.match(%r{\d+[./]\d+[./]\d+}).to_s
    end
  end
end
