# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
registration_data = TestingSiteOnlyoffice::DocsRegistrationData.new
incorrect_email = TestingSiteOnlyoffice::DocsRegistrationData.new.generate_incorrect_data.doc_email

# Tests for user registration were not added because the functionality is being checked in another project, and the tests would be redundant
describe 'Smoke site tests for sign_in and sign_up to Docs Cloud' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  # Tests for successful login to docs_cloud will be added after the implementation of API methods in the project
  describe '[Site][Docs Cloud Sign In Page] /docs-cloud-signin.aspx' do
    before do
      @docs_sign_in_page = @site_home_page.click_link_on_toolbar(:site_docs_registration).open_login_page_from_registration_page
    end

    it 'Failed login to Docs cloud with incorrect e-mail' do
      @docs_sign_in_page.input_email_and_submit(incorrect_email)
      expect(@docs_sign_in_page.email_error_visible?).to be true
    end

    it 'See SLA link works' do
      @docs_sign_in_page.sla_link
      expect(@docs_sign_in_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::SERVICE_LEGAL_AGREEMENT)
    end

    it 'See Privacy statement link works' do
      @docs_sign_in_page.privacy_statement
      expect(@docs_sign_in_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
    end

    it 'Register from sign in page works' do
      result_page = @docs_sign_in_page.register_from_sign_in_page
      expect(result_page).to be_a TestingSiteOnlyoffice::DocsRegistrationPage
    end
  end

  describe '[Site][Docs Cloud Sign Up Page] /docs-registration.aspx' do
    before do
      @docs_cloud_sign_up_page = @site_home_page.click_link_on_toolbar(:site_docs_registration)
    end

    it 'Sign Up online document editors' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      @docs_cloud_sign_up_page.submit_correct_data(registration_data)
      expect(partner_email.check_email_by_subject({ subject: "#{registration_data.full_name} - Docs Registration Request [from: docs-registration]" }, 300, true)).to be true
    end

    it 'Sign Up errors' do
      @docs_cloud_sign_up_page.submit_data(TestingSiteOnlyoffice::DocsRegistrationData.new.generate_incorrect_data)
      expect(@docs_cloud_sign_up_page).to be_all_errors_visible
    end
  end
end
