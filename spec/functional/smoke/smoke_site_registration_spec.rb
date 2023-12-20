# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Smoke' do
  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  describe 'Site' do

    after do
      @test.webdriver.quit
    end

    it '[Site] Check exists languages' do
      site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
      expect(site_home_page.get_all_language_from_site.sort).to eq(TestingSiteOnlyoffice::SiteData.site_languages.sort)
    end

    TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
      describe "Registration #{current_language}" do

        after do
          @test.webdriver.quit
        end

        let(:portal_creation_data) { TestingSiteOnlyoffice::SitePortalCreationData.new.get_instance_hash }
        let(:portal_url) { TestingSiteOnlyoffice::PortalHelper.new.get_full_portal_name(portal_creation_data[:portal_name]) }

        it "Registration from portal sign in page for #{current_language}" do
          TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(portal_creation_data, current_language)
          main_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_and_login_to_portal(portal_creation_data, portal_url)
          expect(main_page).to be_document_module_visible
        end

        it "Check changing to #{current_language} language" do
          main_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
          main_page.set_page_language(current_language)
          expect(main_page.get_page_language).to eq(current_language)
        end

        it "Check Sign In after Sign Up in #{current_language} language" do
          portal_creation_data[:email] = "qa-signin-check-#{Faker::Internet.password}@qamail.teamlab.info"
          TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(portal_creation_data, current_language)
          main_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
          portal_main_page = main_page.click_link_on_toolbar(:get_onlyoffice_sign_in).sign_in(portal_creation_data[:email], portal_creation_data[:password])
          expect(portal_main_page).to be_document_module_visible
        end
      end
    end
  end
end
