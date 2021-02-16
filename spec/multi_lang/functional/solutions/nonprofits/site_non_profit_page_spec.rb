require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Nonprofit page links' do
  before do
    site_home_page, @test = TestingSiteOnlyffice::PortalHelper.new.open_page_teamlab_office
    @nonprofits_page = site_home_page.click_link_on_toolbar(:nonprofits)
  end

  it '[Site][NonProfits] Check link `Learn more about the editors`' do
    @products_docs = @nonprofits_page.click_learn_more_about_editors
    expect(@products_docs).to be_a TestingSiteOnlyffice::SiteProductsDocs
  end

  it '[Site][NonProfits] Check link `Learn more about collaboration platform`' do
    @products_groups = @nonprofits_page.click_learn_more_about_collaboration_platforms
    expect(@products_groups).to be_a TestingSiteOnlyffice::SiteProductsGroups
  end

  it '[Site][NonProfits] Check link `Learn about security`' do
    @products_security = @nonprofits_page.click_learn_more_about_security
    expect(@products_security).to be_a TestingSiteOnlyffice::SiteProductsSecurity
  end

  it '[Site][NonProfits] Check link `Download` for desktop' do
    @download_desktop = @nonprofits_page.click_download
    expect(@download_desktop).to be_a TestingSiteOnlyffice::SiteDesktopApps
  end

  it '[Site][NonProfits] Check link `Download for Android`' do
    @nonprofits_page.nonprofit_android
    expect(@nonprofits_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::MOBILE_GOOGLE)
  end

  it '[Site][NonProfits] Check link `Download for IOS`' do
    @nonprofits_page.nonprofit_ios
    expect(@nonprofits_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::MOBILE_APP_STORE)
  end

  it '[Site][NonProfits] Check button `See all integrations`' do
    @connectors_page = @nonprofits_page.click_see_all_integrations
    expect(@connectors_page).to be_a TestingSiteOnlyffice::SiteConnectors
  end

  it '[Site][NonProfits] Check button `Request free cloud`' do
    @request_free_cloud_page = @nonprofits_page.click_request_free_cloud
    expect(@request_free_cloud_page).to be_a TestingSiteOnlyffice::SiteRequestFreeCloud
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
