# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'training_courses_request_form'

module TestingSiteOnlyoffice
  # /training-courses.aspx
  # https://user-images.githubusercontent.com/40513035/123215191-fd8f6b00-d47c-11eb-838b-c70c7821595f.png
  class SiteAboutTrainingCourses
    include PageObject
    include SiteToolbar

    elements(:courses_module_block, xpath: "//div[@id='modules-item-list']/div/div/h4")
    elements(:courses_purpose_block, xpath: "//div[@id='purpose-item-list']/div/div/h4")
    text_field(:courses_search_field, xpath: "//input[@id='ad-search-input']")
    element(:current_left_side_filter, xpath: "//div[@class='choose-item-type popup-starting-point']/h2")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { courses_search_field_element.present? }
    end

    def courses_modules_names
      courses_modules_names = []
      courses_module_block_elements.each { |element| courses_modules_names << element.text }
      courses_modules_names
    end

    def courses_purpose_names
      courses_purpose_names = []
      courses_purpose_block_elements.each { |element| courses_purpose_names << element.text }
      courses_purpose_names
    end

    def courses_submit_request_xpath(course)
      "//div[contains(@class,'#{course}')]/..//a[@class='button transparent']"
    end

    def courses_block_present?(course)
      @instance.webdriver.element_visible?(courses_submit_request_xpath(course))
    end

    def courses_search(string)
      @instance.webdriver.type_text(courses_search_field_element.selector[:xpath], "#{string}\n")
      sleep 1 # wait for search to end
    end

    def open_and_send_request_courses_form(course)
      @instance.webdriver.driver.find_element(:xpath, courses_submit_request_xpath(course)).click
      courses_request_form = SiteTrainingCoursesRequestForm.new(@instance)
      courses_request_form.send_training_courses_request
    end

    # Left side filter: All, Modules, Purpose
    def click_left_filter_element(type)
      current_left_side_filter_element.click
      filter_xpath = "(//div[@class='filter-selector']/div[text()='#{type}'])[1]"
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(filter_xpath) }
      @instance.webdriver.driver.find_element(:xpath, filter_xpath).click
      @instance.webdriver.wait_until { current_left_side_filter_element.text == type }
    end

    def change_left_filter(type)
      return if current_left_side_filter_element.text == type.to_s

      click_left_filter_element(type.to_s)
    end
  end
end
