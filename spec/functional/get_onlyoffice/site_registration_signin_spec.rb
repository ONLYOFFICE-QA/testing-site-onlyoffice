# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

mail = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN)
mail_site = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
checker = { language: config.language, module: 'WebStudio' }

describe 'Registration new portal' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'Sign Up' do
    let(:sign_up_page) { @site_home_page.click_link_on_toolbar(:sign_up) }

    describe 'Create new portal' do
      let(:portal_creation_data) { TestingSiteOnlyoffice::SitePortalCreationData.new.get_instance_hash }

      it 'Create new portal from "Sign Up"' do
        portal_page = sign_up_page.fill_data(portal_creation_data)
        expect(portal_page.current_user_name).to eq(TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME)
      end

      it 'Check sign up letter: "Welcome to TeamLab Portal!" from "Sign Up"' do
        sign_up_page.fill_data(portal_creation_data)
        portal_url = TestingSiteOnlyoffice::PortalHelper.new.get_full_portal_name(portal_creation_data[:portal_name])
        confirmation_link = TestingSiteOnlyoffice::SiteNotificationHelper.confirmation_registration_link(checker.merge(mail: mail,
                                                                                                                       pattern: 'subject_confirmation',
                                                                                                                       search: portal_url))
        TestingSiteOnlyoffice::SiteHelper.new.registration_confirmation(confirmation_link, portal_creation_data)
        expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(mail: mail,
                                                                                                   pattern: 'subject_congratulations',
                                                                                                   search: portal_url))).to be_truthy
      end
    end

    it 'Create new portal with wrong data from "Sign Up"' do
      sign_up_page.fill_params(first_name: '1', last_name: '2', email: '3', password: '4', portal_name: '5')
      expect(sign_up_page).to be_all_errors_visible
    end

    it 'Check open "Term and conditions" link for "Sign Up' do
      sign_up_page.terms_and_conditions
      expect(sign_up_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::TERMS_OF_USE_FILE_NAME)
    end

    it 'Check open "Privacy statement" link for "Sign Up' do
      sign_up_page.privacy_statement
      expect(sign_up_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
    end
  end

  describe 'Sign in' do
    let(:sign_in_page) { @site_home_page.click_link_on_toolbar(:sign_in) }

    it '"Register" from Sign in page' do
      sign_up_page = sign_in_page.register_from_sign_in
      expect(sign_up_page.first_name_element).to be_present
    end

    it '"Sign in" to new portal' do
      sign_up_page = sign_in_page.register_from_sign_in
      portal_creation_data = TestingSiteOnlyoffice::SitePortalCreationData.new.get_instance_hash
      portal_creation_data[:email] = "qa-signin-check-#{SecureRandom.uuid}@qamail.teamlab.info"
      portal_creation_data[:password] = SecureRandom.uuid
      sign_up_page.fill_data(portal_creation_data)
      @test.webdriver.quit
      site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
      portal_page = site_home_page.click_link_on_toolbar(:sign_in).sign_in(portal_creation_data[:email], portal_creation_data[:password])
      expect(portal_page.current_user_name).to eq(TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME)
    end

    it 'Check mail "Forgot password"' do
      sign_in_page.send_forgot_password(TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(mail: mail_site,
                                                                                                 pattern: 'teamlab_pwd_reminder',
                                                                                                 search: TestingSiteOnlyoffice::SiteData.site_notification_page))).to be_truthy
    end

    it 'Sign in with wrong data' do
      sign_in_page.sign_in('1', '2')
      expect(sign_in_page.sign_in_error_element).to be_present
    end

    TestingSiteOnlyoffice::SiteData.sign_in_with_network_list.each do |network|
      it "Sign in with #{network} window opened" do
        sign_in_with_page = sign_in_page.sign_in_with(network)
        expect(sign_in_with_page).to be_indicator_element_present(network)
      end
    end
  end
end
