# frozen_string_literal: true

module TestingSiteOnlyoffice
  class MailClientPage
    # Helper for mail client
    include PageObject

    text_field(:username, id: 'rcmloginuser')
    text_field(:password, id: 'rcmloginpwd')
    button(:submit_button, id: 'rcmloginsubmit')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
    end

    def login
      @instance.webdriver.open(@instance.private_data['mail_client_link'])
      self.username = @instance.private_data['mail_username']
      self.password = @instance.private_data['mail_password']
      submit_button_element.click
    end

    def open_email_with_subject(subject_text)
      @instance.webdriver.wait_until(timeout: 30) do
        @instance.webdriver.driver.find_elements(xpath: "//span[contains(text(), '#{subject_text}')]").any?
      end
      @instance.webdriver.driver.find_element(xpath: "//span[contains(text(), '#{subject_text}')]").click
    end
  end
end
