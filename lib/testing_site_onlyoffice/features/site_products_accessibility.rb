# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /accessibility.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/5cb8886c-4fbf-4150-a735-e4abee5f8e2b
  class SiteProductsAccessibility
    include PageObject
    include SiteDownloadHelper

    link(:try_now_button, xpath: '//a[contains(@class, "button red")]')
    div(:mobility_tab, xpath: '//div[(@id = "accessibility-mobility")]')
    div(:neurodiversity_tab, xpath: '//div[(@id = "accessibility-neurodiversity")]')
    link(:screen_readers_learn_more, xpath: '(//a[contains(@class, "inner_link")])[1]')
    link(:ui_tweaks_learn_more, xpath: '(//a[contains(@class, "inner_link")])[2]')
    link(:color_modes_learn_more, xpath: '(//a[contains(@class, "inner_link")])[3]')
    link(:hotkeys_learn_more, xpath: '(//a[contains(@class, "inner_link")])[4]')
    link(:speech_input_learn_more, xpath: '(//a[contains(@class, "inner_link")])[5]')
    link(:alternative_text_learn_more, xpath: '(//a[contains(@class, "inner_link")])[6]')
    link(:autocorrect_features_learn_more, xpath: '(//a[contains(@class, "inner_link")])[7]')
    link(:speech_learn_more, xpath: '(//a[contains(@class, "inner_link")])[8]')
    link(:typograf_learn_more, xpath: '(//a[contains(@class, "inner_link")])[9]')
    link(:translator_learn_more, xpath: '(//a[contains(@class, "inner_link")])[10]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(try_now_button_element)
      end
    end

    def click_try_now
      try_now_button_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_screen_readers_learn_more
      screen_readers_learn_more_element.click
      @instance.webdriver.choose_tab(2)
      SiteAboutBlog.new(@instance)
    end

    def click_hotkeys_learn_more
      mobility_tab_element.click
      hotkeys_learn_more_element.click
    end

    def click_speech_input_learn_more
      mobility_tab_element.click
      speech_input_learn_more_element.click
    end

    def click_alternative_text_learn_more
      neurodiversity_tab_element.click
      alternative_text_learn_more_element.click
    end

    def click_autocorrect_features_learn_more
      neurodiversity_tab_element.click
      autocorrect_features_learn_more_element.click
    end

    def click_speech_learn_more
      neurodiversity_tab_element.click
      speech_learn_more_element.click
      SiteMarketplacePluginPage.new(@instance)
    end

    def click_typograf_learn_more
      neurodiversity_tab_element.click
      typograf_learn_more_element.click
      SiteMarketplacePluginPage.new(@instance)
    end

    def click_translator_learn_more
      neurodiversity_tab_element.click
      translator_learn_more_element.click
      SiteMarketplacePluginPage.new(@instance)
    end
  end
end
