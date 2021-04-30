# Go to link in mail for confirm subscribe
# https://user-images.githubusercontent.com/3971732/43830155-53b20eda-9b09-11e8-97fa-78a27aa53e94.png
module TestingSiteOnlyoffice
  class SiteSubscribeConfirmation
    include PageObject

    def initialize(instance)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      wait_success_text_visible?
    end

    def wait_success_text_visible?
      @instance.webdriver.element_present?("//div[@class='description']/p[contains(text(), 'successfully subscribed')]") ||
        @instance.webdriver.element_present?("//*[@id='subscribepage']//h1[contains(text(), 'Thank you for subscribing')]")
    end
  end
end
