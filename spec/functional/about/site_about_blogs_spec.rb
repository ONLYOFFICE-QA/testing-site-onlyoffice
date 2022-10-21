# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'About blogs' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_blogs_page = site_home_page.click_link_on_toolbar(:about_blog)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[About blogs] Names of download buttons' do
    expect(@about_blogs_page.desktop_and_mobile_app).to eq(TestingSiteOnlyoffice::SiteData.blogs_download_app)
  end

  it '[About blogs] Go to app GooglePlay' do
    expect(@about_blogs_page.check_google_play_link).to be true
  end

  it '[About blogs] Go to app App Store' do
    expect(@about_blogs_page.check_app_store_link).to be true
  end

  TestingSiteOnlyoffice::SiteData.download_desktop_apps.each do |apps|
    it "[About blogs] Go to desktop #{apps}" do
      expect(@about_blogs_page.go_to_desktop_apps(apps)).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
    end
  end
end
