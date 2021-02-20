require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Desktop apps' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
    @mobile_app_page = site_home_page.click_link_on_toolbar(:desktop_mobile_apps).open_mobile_apps
  end

  it '[Mobile][Android]Check "Get it on Google play" button' do
    @mobile_app_page.site_mobile_google_play
    expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_GOOGLE)
  end

  context 'IOS' do
    it '[Mobile][iOS]Check "Download on the app store" button' do
      @mobile_app_page.site_mobile_app_store
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_APP_STORE)
    end

    it '[Mobile][iOS]Check "Whats new" link' do
      @mobile_app_page.site_mobile_ios_whats_new
      expect(@mobile_app_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_IOS_CHANGELOG)
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
