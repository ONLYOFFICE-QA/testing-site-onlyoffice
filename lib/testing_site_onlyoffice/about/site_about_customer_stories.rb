# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /customers.aspx?from=about
  # https://user-images.githubusercontent.com/67409742/144017777-7ab38c8e-db5a-4fe3-b9c1-52c5219a3640.png
  class SiteAboutCustomerStories
    include PageObject

    div(:customer_stories, xpath: '//div[@class="customerspage_header_buttons"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(customer_stories_element) }
    end
  end
end
