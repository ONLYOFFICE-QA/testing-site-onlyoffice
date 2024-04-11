# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Mobile apps' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @mobile_app_page = site_home_page.click_link_on_toolbar(:get_onlyoffice_desktop_mobile).open_mobile_apps
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'ONLYOFFICE Documents mobile App' do
    it '[Mobile][ONLYOFFICE Documents for Android] Check "Get it on Google play" button' do
      @mobile_app_page.oo_documents_google_play
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_GOOGLE)
    end

    it '[Mobile][ONLYOFFICE Documents for Huawei] Check "Explore it on AppGallery" button' do
      @mobile_app_page.oo_documents_appgallery
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_APP_GALLERY)
    end

    it '[Mobile][ONLYOFFICE Documents for Galaxy] Check "Available on Galaxy Store" button' do
      @mobile_app_page.oo_documents_galaxy_store
      expect(@mobile_app_page.check_opened_page_title).to include(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_GALAXY_STORE)
    end

    it '[Mobile][ONLYOFFICE Documents for iOS] Check "Download on the app store" button' do
      @mobile_app_page.oo_documents_app_store
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_APP_STORE)
    end

    it '[Mobile][ONLYOFFICE Documents for iOS] Check "Whats new" link' do
      @mobile_app_page.oo_documents_ios_whats_new
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_IOS_CHANGELOG)
    end
  end

  describe 'ONLYOFFICE Projects mobile Apps' do
    it '[Mobile][ONLYOFFICE Projects for Android] Check "Get it on Google play" button' do
      @mobile_app_page.oo_projects_google_play
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_PROJECTS_GOOGLE)
    end

    it '[Mobile][ONLYOFFICE Projects for Huawei] Check "Explore it on AppGallery" button' do
      @mobile_app_page.oo_projects_appgallery
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_PROJECTS_APP_GALLERY)
    end

    it '[Mobile][ONLYOFFICE Projects for iOS] Check "Download on the app store" button' do
      @mobile_app_page.oo_projects_app_store
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_PROJECTS_APP_STORE)
    end
  end
end
