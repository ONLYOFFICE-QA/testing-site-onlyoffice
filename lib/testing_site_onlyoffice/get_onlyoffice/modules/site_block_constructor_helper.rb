# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper methods for constructor block installers
  module SiteBlockConstructorHelper
    def click_constructor_link(xpath)
      @instance.webdriver.get_element(xpath).click
      wait_for_long_loading_page(xpath)
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

    private

    # Additional wait if loading page usually very long
    # This is very actual for appimage hub page
    # And sometimes for helpcenter page
    def wait_for_long_loading_page(xpath)
      sleep(60 * 3) if xpath.include?('appimage')
    end
  end
end
