require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

SettingsData::EMAIL = SettingsData::EMAIL_ADMIN

mail = IredMailHelper.new(username: SettingsData::EMAIL_ADMIN)
mail_site = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
checker = { language: StaticDataTeamLab.current_language, module: 'WebStudio' }

describe 'Registration new portal' do
  before do
    @portal_creation_data = PortalCreationData.new
    @site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
  end

  context 'Sign Up' do
    before { @sign_up_page = @site_home_page.click_link_on_toolbar(:sign_up) }

    it 'Create new portal from "Sign Up"' do
      portal_page = @sign_up_page.fill_data(portal_name: @portal_creation_data.portal_to_create)
      expect(portal_page.current_user_name).to eq(AuthData::DEFAULT_ADMIN_FULLNAME)
    end

    it 'Check sign up letter: "Welcome to TeamLab Portal!" from "Sign Up"' do
      @sign_up_page.fill_data(portal_name: @portal_creation_data.portal_to_create)
      portal_name = TestingSiteOnlyoffice::PortalHelper.new.get_full_portal_name(@portal_creation_data.portal_to_create)
      confirmation_link = TestingSiteOnlyoffice::SiteNotificationHelper.confirmation_registration_link(checker.merge(mail: mail,
                                                                                                                     pattern: 'subject_confirmation',
                                                                                                                     search: portal_name))
      @sign_in_page = TestingSiteOnlyoffice::SiteHelper.new.registration_confirmation(confirmation_link)
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(mail: mail,
                                                                                                 pattern: 'subject_congratulations',
                                                                                                 search: portal_name))).to be_truthy
    end

    it 'Create new portal with wrong data from "Sign Up"' do
      @sign_up_page.fill_params(username: '1', last_name: '2', email: '3', password: '4', portal_name: '5')
      expect(@sign_up_page).to be_all_errors_visible
    end

    it 'Check open "Term and conditions" link for "Sign Up' do
      @sign_up_page.terms_and_conditions
      expect(@sign_up_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::TERMS_OF_USE_FILE_NAME)
    end

    it 'Check open "Privacy statement" link for "Sign Up' do
      @sign_up_page.privacy_statement
      expect(@sign_up_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
    end
  end

  context 'Sign in' do
    before { @sign_in_page = @site_home_page.click_link_on_toolbar(:sign_in) }

    it '"Register" from Sign in page' do
      sign_up_page = @sign_in_page.register_from_sign_in
      expect(sign_up_page.first_name_element).to be_present
    end

    it '"Sign in" to new portal' do
      @sign_up_page = @sign_in_page.register_from_sign_in
      password = SecureRandom.uuid
      @sign_up_page.fill_data(portal_name: @portal_creation_data.portal_to_create, password: password)
      @test.webdriver.quit
      site_home_page, @test = PortalHelper.new.open_page_teamlab_office
      sign_in_page = site_home_page.click_link_on_toolbar(:sign_in)
      portal_page = sign_in_page.sign_in(SettingsData::EMAIL_ADMIN, password)
      expect(portal_page.current_user_name).to eq(AuthData::DEFAULT_ADMIN_FULLNAME)
    end

    it 'Check mail "Forgot password"' do
      @sign_in_page.send_forgot_password(TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(mail: mail_site,
                                                                                                 pattern: 'teamlab_pwd_reminder',
                                                                                                 search: TestingSiteOnlyoffice::SiteData::PORTAL_ADDRESS))).to be_truthy
    end

    it 'Sign in with wrong data' do
      @sign_in_page.sign_in('1', '2')
      expect(@sign_in_page.sign_in_error_element).to be_present
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
