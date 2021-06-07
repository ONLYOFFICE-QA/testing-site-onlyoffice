# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper methods for constructor block installers
  module SiteBlockConstructorHelper
    def click_constructor_link(xpath)
      @instance.webdriver.get_element(xpath).click
    end

    def get_installer_release_date_or_version(date_xpath)
      date_text = @instance.webdriver.get_text(date_xpath)
      fetch_release_date_or_version(date_text)
    end

    def fetch_release_date_or_version(text)
      date_version = text.match(%r{\d+[./]\d+[./]\d+}).to_s
      return date_version unless date_version.empty?

      text.match(%r{\d+[./]\d+}).to_s
    end
  end
end
