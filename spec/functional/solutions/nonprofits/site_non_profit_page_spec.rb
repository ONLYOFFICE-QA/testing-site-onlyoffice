# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Nonprofit page links' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @nonprofits_page = site_home_page.click_link_on_toolbar(:nonprofits)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][NonProfits] Check link `Learn more about the editors`' do
    @products_docs = @nonprofits_page.click_learn_more_about_editors
    expect(@products_docs).to be_a TestingSiteOnlyoffice::SiteProductsDocs
  end

  it '[Site][NonProfits] Check link `Learn more about collaboration platform`' do
    @products_groups = @nonprofits_page.click_learn_more_about_collaboration_platforms
    expect(@products_groups).to be_a TestingSiteOnlyoffice::SiteProductsGroups
  end

  it '[Site][NonProfits] Check link `Learn about security`' do
    @products_security = @nonprofits_page.click_learn_more_about_security
    expect(@products_security).to be_a TestingSiteOnlyoffice::SiteProductsSecurity
  end

  it '[Site][NonProfits] Check link `Download` for desktop' do
    @download_desktop = @nonprofits_page.click_download
    expect(@download_desktop).to be_a TestingSiteOnlyoffice::SiteDesktopApps
  end

  it '[Site][NonProfits] Check link `Download for Android`' do
    @nonprofits_page.nonprofit_android
    expect(@nonprofits_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_GOOGLE)
  end

  it '[Site][NonProfits] Check link `Download for IOS`' do
    @nonprofits_page.nonprofit_ios
    expect(@nonprofits_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_APP_STORE)
  end

  it '[Site][NonProfits] Check button `See all integrations`' do
    @connectors_page = @nonprofits_page.click_see_all_integrations
    expect(@connectors_page).to be_a TestingSiteOnlyoffice::SiteProductsConnectorsOnlyoffice
  end

  it '[Site][NonProfits] Check button `Request free cloud`' do
    @request_free_cloud_page = @nonprofits_page.click_request_free_cloud
    expect(@request_free_cloud_page).to be_a TestingSiteOnlyoffice::SiteRequestFreeCloud
  end
end
