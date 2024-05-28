# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
docspace_client_email = TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL
docspace_client_password = TestingSiteOnlyoffice::SiteData::DOCSPACE_PASSWORD
client_email_to_check = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)

# Tests for user registration were not added because the functionality is being checked in another project, and the tests would be redundant
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
      @docspace_sign_in = @site_home_page.click_link_on_toolbar(:get_onlyoffice_docspace_sign_in)
    end

    it '[Site][Docspace Sign in] Successful login to DocSpace' do
      pending('because of domains connection specifics') if config.server.include?('teamlab.info')
      result_page = @docspace_sign_in.email_and_password_submit(email: docspace_client_email, password: docspace_client_password)
      expect(result_page).to be_a TestingSiteOnlyoffice::DocSpaceMainPage
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
      @docspace_sign_up = @site_home_page.click_link_on_toolbar(:get_onlyoffice_docspace_sign_up)
    end

    it '[Site][Docspace Sign up] Terms and conditions link works' do
      @docspace_sign_up.terms_and_conditions
      expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::DOCSPACE_TERMS)
    end

    it '[Site][Docspace Sign up] Privacy statement link works' do
      @docspace_sign_up.privacy_statement
      expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
    end
  end
end
