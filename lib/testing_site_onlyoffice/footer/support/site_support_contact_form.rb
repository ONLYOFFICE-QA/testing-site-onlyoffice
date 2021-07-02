# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /support-contact-form.aspx
  # https://user-images.githubusercontent.com/40513035/124235167-c72f9c80-dac9-11eb-8640-3721f4099865.png
  class SiteSupportContactForm
    include PageObject

    span(:support_product_dropdown, xpath: "//span[contains(@class, 'productSelect')]")
    span(:support_subject_dropdown, xpath: "//span[contains(@class, 'curThemeSelect')]")
    text_field(:support_name, xpath: "//input[@id='txtFirstName']")
    text_field(:support_email, xpath: "//input[@id='txtEmail']")
    text_field(:support_phone, xpath: "//input[@id='txtPhone']")

    text_field(:submit_request, xpath: "//input[@id='sbmtRequest']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { support_name_element.present? }
    end

    def send_training_courses_request(data = {})
      fill_support_contact_form(data)
      @instance.webdriver.wait_until { request_button_active? }
      submit_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end

    def request_button_active?
      submit_request_element.attribute('class') == 'button red'
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('succesfulReq')
    end

    def fill_support_contact_form(params = {})
      product = params.fetch(:product, 'Cloud Service')
      change_product(product)
      subject = params.fetch(:subject, 'Presale')
      change_subject(subject)
      self.support_name = params.fetch(:name, "NCT Test #{Faker::Name.name}")
      self.support_email = params.fetch(:email, SiteData::CLIENT_EMAIL)
      self.support_phone = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
    end

    def dropdown_element_xpath(language)
      "//li[@data-value='#{language}']"
    end

    def change_product(product)
      support_product_dropdown_element.click
      choose_dropdown_element(product)
    end

    def change_subject(subject)
      support_subject_dropdown_element.click
      choose_dropdown_element(subject)
    end

    def choose_dropdown_element(item_to_select)
      xpath = dropdown_element_xpath(item_to_select)
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(xpath) }
      @instance.webdriver.driver.find_element(:xpath, xpath).click
    end
  end
end
