# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Top toolbar languages selector
  # https://user-images.githubusercontent.com/40513035/95858305-90f89400-0d65-11eb-95a1-3aa66b1258d0.png
  module SiteLanguages
    include PageObject

    div(:page_language, xpath: '//div[@id="LanguageSelector"]//div[contains(@class, "title")]')
    elements(:language_select, xpath: '//div[@id="LanguageSelector"]/ul/li')

    def get_page_language
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(page_language_element)
      end
      page_language_element.attribute('class').split.at(1)
    end

    def set_page_language(lang_to_set)
      return if lang_to_set.nil?
      return if lang_to_set == get_page_language

      open_list_languages_page unless @instance.webdriver.element_present?(language_select_elements[1])
      xpath_of_lang = "//li[@class='option #{lang_to_set}']/a"
      @instance.webdriver.click_on_locator xpath_of_lang
    end

    def open_list_languages_page
      xpath_page_languages = '//div[@id="LanguageSelector"]//div[contains(@class, "title")]'
      @instance.webdriver.move_to_element_by_locator(xpath_page_languages)
      page_language_element.click unless @instance.webdriver.element_present?(language_select_elements[1])
    end

    def get_all_language_from_site
      open_list_languages_page
      languages = []
      language_select_elements.each do |current_language|
        language = current_language.attribute('class').split.at(1)
        languages << language if current_language.visible?
      end
      languages
    end
  end
end
