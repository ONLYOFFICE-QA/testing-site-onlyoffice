# Sign in page
# https://user-images.githubusercontent.com/40513035/95858216-69a1c700-0d65-11eb-9255-5d2361a7d772.png
require_relative '../modules/site_toolbar'

module TestingSiteOnlyoffice
  class SiteSignIn
    attr_accessor :instance

    include PageObject
    include SiteToolbar
    include GoogleLoginPage
    include FacebookLoginPage
    include LinkinLoginPage
    include TwitterLoginPage

    # form sign in
    text_field(:email_sign_in, xpath: '//*[@id="txtSignInEmail"]')
    text_field(:password_sign_in, xpath: '//*[@id="txtSignPassword"]')
    link(:register_sign_in, xpath: '//a[@class = "registrationLink"]')
    link(:forgot_password_sign_in, xpath: '//*[@id="passRestorelink"]')
    element(:sign_in_button, xpath: '//*[@id="target"]//input[@type="button"]')
    link(:close_cross, xpath: '//*[@id="SignInPanel"]/div[1]/div')
    div(:sign_in_error, xpath: '//div[@id="divSigninError"]')

    # restore password
    text_field(:email_forgot_password_sign_in, xpath: '//*[@id="passwordRestoreInput"]')
    button(:send_forgot_password_sign_in, xpath: '//*[@id="PasswordRestoreFinishButton"]')

    link(:google_sign_in, xpath: '//*[@id="aspnetForm"]//a[contains(@href, "google")]')
    link(:facebook_sign_in, xpath: '//*[@id="aspnetForm"]//a[contains(@href, "facebook")]')
    link(:twitter_sign_in, xpath: '//*[@id="aspnetForm"]//a[contains(@href, "twitter")]')
    link(:linkedin_sign_in, xpath: '//*[@id="aspnetForm"]//a[contains(@href, "linkedin")]')

    elements(:address_portal, xpath: '//*[@id="PortalChoosePortalsDiv"]/div/a')
    image(:top_logo, xpath: '//div[@id="studioPageContent"]//a[contains(@class,"top-logo")]/img')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        email_sign_in_visible?
      end
    end

    def email_sign_in_visible?
      email_sign_in_element.present?
    end

    def click_forgot_password_from_sign_in
      forgot_password_sign_in
      @instance.webdriver.wait_until do
        email_forgot_password_sign_in_element.present?
      end
    end

    def send_forgot_password(email)
      click_forgot_password_from_sign_in
      self.email_forgot_password_sign_in = email
      send_forgot_password_sign_in
      @instance.webdriver.wait_until 90 do
        !send_forgot_password_sign_in_element.present?
      end
    end

    def click_close_cross_sign_in
      close_cross
      @instance.webdriver.wait_until do
        !email_sign_in_visible?
      end
    end

    def sign_in_to_teamlab_site(site_data, name_network = :teamlab)
      @instance.webdriver.wait_until do
        email_sign_in_visible?
      end
      unless name_network == :teamlab
        network_link = { google: google_sign_in_element, facebook: facebook_sign_in_element,
                         twitter: twitter_sign_in_element, linkedin: linkedin_sign_in_element }
        network_link[name_network].click
      end
      case name_network
      when :google
        google_login(site_data.portal_login, site_data.portal_pwd)
      when :facebook
        facebook_login(site_data.portal_login, site_data.portal_pwd, false)
      when :twitter
        twitter_login(site_data.portal_login, site_data.portal_pwd)
      when :linkedin
        linkedin_login(site_data.portal_login, site_data.portal_pwd)
      else
        self.email_sign_in = site_data.portal_login
        self.password_sign_in = site_data.portal_pwd
        sign_in_button_element.click
      end
      @instance.webdriver.wait_until(100) do
        !address_portal_elements.empty? || top_logo_visible?
      end
      choose_your_portal(site_data.portal_name) if site_data.portal_name && !address_portal_elements.empty?
      @instance.webdriver.wait_until do
        top_logo_visible?
      end
    end

    def input_credentials(email, pwd)
      self.email_sign_in = email
      self.password_sign_in = pwd
    end

    def sign_in(email, pwd)
      input_credentials(email, pwd)
      sign_in_button_element.click
      return if sign_in_error_element.present?

      @instance.webdriver.wait_until(100) { !email_sign_in_element.present? }
      MainPage.new(@instance)
    end

    def can_sign_in_with_credentials?(portal, email, pwd)
      input_credentials(email, pwd)
      sign_in_button_element.click
      @instance.webdriver.wait_until(100) { !address_portal_elements.empty? }
      portal_in_list?(portal)
    end

    def top_logo_visible?
      top_logo_element.present?
    end

    def choose_your_portal(address)
      address_portal_elements.each do |current_address|
        return @instance.webdriver.click(current_address) if @instance.webdriver.get_text(current_address) == address
      end
      raise "Dont exist portal name #{address} in list portal"
    end

    def portal_in_list?(addr)
      !!address_portal_elements.detect { |portal| portal.text == addr }
    end

    def register_from_sign_in
      register_sign_in_element.click
      SiteSignUp.new(@instance)
    end
  end
end
