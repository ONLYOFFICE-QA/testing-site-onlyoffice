# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Products DocSpace' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docspace_page = site_home_page.click_link_on_toolbar(:features_docspace)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  TestingSiteOnlyoffice::SiteDocSpaceMainPage::FEATURES_LINKS.each do |feature_key, feature_info|
    it_behaves_like 'checking_editors_links', feature_key, feature_info
    let(:page) { @docspace_page }
  end

  it '[Site Products] [DocsSpace] Create account button works' do
    expect(@docspace_page.click_registration_button).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site Products] [DocsSpace] "Zoom collaboration / learn more" button works' do
    expect(@docspace_page.click_zoom_collaboration_learn_more).to be_a TestingSiteOnlyoffice::SiteConnectorsZoom
  end

  it '[Site Products] [DocsSpace] "Security / learn more" button works' do
    expect(@docspace_page.click_security_learn_more).to be_a TestingSiteOnlyoffice::SiteFeaturesSecurity
  end

  it '[Site Products] [DocsSpace] "Free cloud for startups" button works' do
    expect(@docspace_page.click_free_cloud_startups).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site Products] [DocsSpace] Business cloud "check prices" button works' do
    expect(@docspace_page.click_business_check_prices).to be_a TestingSiteOnlyoffice::SitePricingDocSpacePrices
  end

  it '[Site Products] [DocsSpace] "Enterprise - get it now" button works' do
    expect(@docspace_page.click_enterprise_get_it_now).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
  end

  it '[Site Products] [DocsSpace] "Start free cloud account" button works' do
    expect(@docspace_page.click_docspace_start_free_cloud).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site Products] [DocsSpace] "Deploy on your own server" button works' do
    expect(@docspace_page.click_deploy_on_your_own_server).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
  end

  it '[Site Products] [DocsSpace] "Connectors - get it now" button works' do
    expect(@docspace_page.click_connectors_get_it_now).to be_a TestingSiteOnlyoffice::SiteConnectorsOnlyoffice
  end

  it '[Site Products] [DocsSpace] "Download desktop" button works' do
    expect(@docspace_page.click_download_pc_now).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
  end

  it '[Site Products] [DocsSpace] "Install mobile" button works' do
    expect(@docspace_page.click_mobile_install_now).to be_a TestingSiteOnlyoffice::SiteMobileApps
  end
end
