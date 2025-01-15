# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
docspace_client_email = TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL
client_email_to_check = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)

describe 'Smoke site tests for sign in and sign up Docspace' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe '[Site][Docspace Sign in Page] /docspace-signin.aspx' do
    before do
      @docspace_sign_in = @site_home_page.click_link_on_toolbar(:site_get_onlyoffice_docspace_sign_up).log_in_from_register_page
    end

    it '[Site][Docspace Sign in] Register from sign_in link works' do
      result_page = @docspace_sign_in.register_from_sign_in
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it '[Site][Docspace Sign in] Restore password works' do
      @docspace_sign_in.restore_password_from_sign_in(docspace_client_email)
      expect(client_email_to_check.check_email_by_subject({ subject: 'ONLYOFFICE Password Reminder' }, 300, true)).to be true
    end
  end

  describe '[Site][Docspace Sign up Page] /docspace-registration.aspx' do
    before do
      @docspace_sign_up = @site_home_page.click_link_on_toolbar(:site_get_onlyoffice_docspace_sign_up)
    end

    it '[Site][Docspace Sign up] Terms and conditions link works' do
      @docspace_sign_up.terms_and_conditions
      expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::DOCSPACE_TERMS)
    end

    it '[Site][Docspace Sign up] Privacy statement link works' do
      @docspace_sign_up.privacy_statement
      expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
    end

    it '[Site][Docspace Sign in] Successful sign up and log in to DocSpace' do
      skip 'Cannot test email notifications in production' if config.server.include?('.com')
      result_page = @docspace_sign_up.complete_registration_form
      expect(result_page).to be_a TestingSiteOnlyoffice::DocSpaceMainPage
      expect(client_email_to_check.check_email_by_subject({ subject: 'Welcome to ONLYOFFICE DocSpace!' }, 300, true)).to be true
    end
  end
end
