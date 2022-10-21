# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /vacancies.aspx
  # https://user-images.githubusercontent.com/67409742/161936319-8236c5d9-f94b-4aa7-b1eb-32d3a6e7faac.png
  class SiteAboutJobs
    include PageObject

    element(:job_header, xpath: '//div[@class="filter-block"]/h3')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(job_header_element) }
      return true if @instance.webdriver.get_text(job_header_element) == 'Job openings'

      @instance.webdriver.webdriver_error("The page 'Jobs' didn't load or doesn't match the title")
    end
  end
end
