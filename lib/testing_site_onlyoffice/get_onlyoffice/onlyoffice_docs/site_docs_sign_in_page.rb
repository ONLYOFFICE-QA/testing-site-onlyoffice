# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /docs-cloud-signin.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/37df6529-ac77-484d-ba31-3354ddd478b3
  class SiteDocsSignInPage
    include PageObject

    text_field(:docs_cloud_email_input, xpath: '//input[@id = "txtSignInEmail"]')
    element(:send_email, xpath: '//input[@id = "signIn"]')
    element(:register_link, xpath: '//a[@class = "registrationLink"]')
    div(:email_error, xpath: '//div[@id = "divSigninEmailError"]')
    link(:sla_link, xpath: '//a[contains(text(), "SLA")]')
    link(:privacy_statement, xpath: '//a[contains(text(), "Privacy statement")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(docs_cloud_email_input_element)
      end
    end

    def input_email_and_submit(email)
      docs_cloud_email_input_element.send_keys(email)
      @instance.webdriver.click_on_locator(send_email_element)
    end

    def register_from_sign_in_page
      register_link_element.click
      DocsRegistrationPage.new(@instance)
    end

    def email_error_visible?
      @instance.webdriver.element_visible?('//div[@id = "divSigninEmailError"]')
    end

    def check_opened_file_name
      @instance.webdriver.choose_tab(2)
      @instance.init_online_documents
      @instance.doc_instance.management.wait_for_operation_with_round_status_canvas
      @instance.doc_instance.doc_editor.top_toolbar.title_row.document_name
    end
  end
end
