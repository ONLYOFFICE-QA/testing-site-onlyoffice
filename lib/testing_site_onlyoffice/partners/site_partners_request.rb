# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /partnership-request.aspx
  # https://user-images.githubusercontent.com/40513035/102610597-892ae680-413e-11eb-9fb3-2911ff59e420.png
  class SitePartnersRequest
    include PageObject
    include SiteToolbar

    text_field(:first_name_partner, xpath: '//input[@id="partnerFirstName"]')
    text_field(:last_name_partner, xpath: '//input[@id="partnerLastName"]')
    text_field(:position_partner, xpath: '//input[@id="partnerPosition"]')
    text_field(:email_partner, xpath: '//input[@id="partnerEmail"]')
    text_field(:phone_partner, xpath: '//input[@id="partnerPhone"]')
    text_field(:company_name_partner, xpath: '//input[@id="partnerCompanyName"]')
    text_field(:company_website_partner, xpath: '//input[@id="partnerWebsite"]')
    text_field(:company_number_employees, xpath: '//input[@id="partnerEmployeesCount"]')
    text_area(:additional_information, xpath: '//textarea[@id="partnerSubjMatter"]')

    # target market segments
    checkbox(:government, xpath: '//input[@id="Government"]')
    checkbox(:education, xpath: '//input[@id="Education"]')
    checkbox(:commerce, xpath: '//input[@id="Commerce"]')
    checkbox(:fortune_500_companies, xpath: '//input[@id="Fortune500companies"]')
    checkbox(:small_enterprises, xpath: '//input[@id="SaMSEnterprises"]')
    checkbox(:industry, xpath: '//input[@id="Industry"]')
    checkbox(:other, xpath: '//input[@id="OtherSegments"]')

    # currently partner for any company
    label(:current_partner_yes, xpath: '//label[@for="partner-radio-yes"]')
    label(:current_partner_no, xpath: '//label[@for="partner-radio-no"]')
    text_field(:current_partner_specify, xpath: '//input[@id="pleaseSpecify"]')

    text_field(:submit_request, xpath: '//input[@id="partnerRequestBtn"]')
    text_field(:partner_request_successful, xpath: '//*[@id="PartnerRequestSuccess"]//input')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { submit_request_element.present? }
    end

    def send_partners_form_random_data(params = {})
      self.first_name_partner = params.fetch(:first_name, Faker::Name.first_name)
      self.last_name_partner = params.fetch(:last_name, Faker::Name.last_name)
      self.position_partner = params.fetch(:position, Faker::Company.profession)
      self.email_partner = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.phone_partner = params.fetch(:phone, Faker::PhoneNumber.cell_phone_in_e164)
      self.company_name_partner = params.fetch(:company_name, Faker::Company.name)
      self.company_website_partner = params.fetch(:website, Faker::Internet.domain_name)
      self.company_number_employees = params.fetch(:number_of_employees, Faker::Number.decimal_part(digits: 2))
      choose_marker_segment(params.fetch(:market_segment, :government))
      partner_for_other_company(params.fetch(:current_partner, :no))
      submit_request_element.click
      @instance.webdriver.wait_until { partner_request_successful_element.present? }
    end

    def choose_marker_segment(segment)
      case segment
      when :government
        click_segment_checkbox(government_element) unless government_checked?
      when :education
        click_segment_checkbox(education_element) unless education_checked?
      when :commerce
        click_segment_checkbox(commerce_element) unless commerce_checked?
      when :fortune_500_companies
        click_segment_checkbox(fortune_500_companies_element) unless fortune_500_companies_checked?
      when :small_enterprises
        click_segment_checkbox(small_enterprises_element) unless small_enterprises_checked?
      when :industry
        click_segment_checkbox(industry_element) unless industry_checked?
      when :other
        click_segment_checkbox(other_element) unless other_checked?
      end
    end

    def click_segment_checkbox(element)
      segment_checkbox_xpath = "#{element.selector[:xpath]}/../span"
      @instance.webdriver.click_on_locator(segment_checkbox_xpath)
    end

    def partner_for_other_company(status = :yes)
      case status
      when :yes
        current_partner_yes_element.click unless current_partner_specify_element.present?
      when :no
        current_partner_no_element.click if current_partner_specify_element.present?
      end
    end
  end
end
