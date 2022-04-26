# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /form-creator.aspx
  # https://user-images.githubusercontent.com/67409742/165291126-5292bafa-d11a-4c87-93b5-3c604080ac5d.png
  class SiteProductsFormCreator
    include PageObject
    include SiteToolbar

    div(:form_creator, xpath: "//div[@class='ddb_examples_editors']")
    link(:run_on_your_own_server, xpath: "//a[@class='button red']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(run_on_your_own_server_element) && @instance.webdriver.element_present?(form_creator_element) }
    end
  end
end
