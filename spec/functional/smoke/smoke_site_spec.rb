require 'spec_helper'
require 'timeout'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

mail = IredMailHelper.new(username: SettingsData::EMAIL_ADMIN)

checker = { mail: mail, module: 'WebStudio' }

describe 'Site Smoke' do
  before do
    @portal_creation_data = PortalCreationData.new
  end

  describe 'Site' do
    it '[Site] Check exists languages' do
      site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
      expect(site_home_page.get_all_language_from_site).to eq(TestingSiteOnlyoffice::SiteData.site_languages)
    end

    TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
      describe "Registration #{current_language}" do
        it "Registration from portal sign in page for #{current_language}" do
          admin = TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(@portal_creation_data, current_language)
          main_page, @test = TestingSiteOnlyoffice::PortalHelper.new.init_instance(admin)
          expect(main_page.check_visible_main_page_current_module(:documents)).to eq(true)
        end

        it "Check welcome message for #{current_language}" do
          admin = TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(@portal_creation_data, current_language,
                                                                                           AuthData::DEFAULT_ADMIN_NAME, SettingsData::EMAIL_ADMIN)
          confirmation_link = TestingSiteOnlyoffice::SiteNotificationHelper.confirmation_registration_link(checker.merge(language: current_language,
                                                                                                                         pattern: 'subject_confirmation',
                                                                                                                         search: admin.portal))
          @sign_in_page = TestingSiteOnlyoffice::SiteHelper.new.registration_confirmation(confirmation_link)
          expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(language: current_language,
                                                                                                     pattern: 'subject_congratulations',
                                                                                                     search: admin.portal))).to be_truthy
        end

        it "Check changing to #{current_language} language" do
          main_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
          main_page.set_page_language(current_language)
          expect(main_page.get_page_language).to eq(current_language)
        end

        it "Check Sign In after Sign Up in #{current_language} language" do
          admin_mail = "qa-signin-check-#{Faker::Internet.password}@qamail.teamlab.info"
          admin = TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(@portal_creation_data, current_language,
                                                                                           AuthData::DEFAULT_ADMIN_NAME, admin_mail)
          main_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
          @portal_creation_data.portal_name = admin.portal
          @portal_creation_data.portal_login = admin_mail
          sign_in_page = main_page.sign_in_from_sign_in(@portal_creation_data)
          expect(sign_in_page).to be_top_logo_visible
        end
      end

      describe "Open registration page #{current_language}" do
        before do
          @site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
          @site_home_page.set_page_language(current_language)
        end

        it "Open trial form Pricing->Cloud Service page in #{current_language} language" do
          pricing_cloud_page = @site_home_page.click_link_on_toolbar(:pricing_cloud)
          sign_up_page = pricing_cloud_page.click_start_free_trial
          expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteSignUp
        end

        it "Open Sing Up page from Sign In page in #{current_language} language" do
          sign_in_page = @site_home_page.click_link_on_toolbar(:sign_in)
          sign_up_page = sign_in_page.register_from_sign_in
          expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteSignUp
        end
      end
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test&.webdriver&.quit
  end
end
