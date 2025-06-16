# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'All enterprise solutions' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @all_enterprise_solutions = @site_home_page.open_for_enterprise_page
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'DocSpace "Use it for free" link works' do
    result_page = @all_enterprise_solutions.click_docspace_use_for_free
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it 'DocSpace "Run on your own server" link works' do
    result_page = @all_enterprise_solutions.click_docspace_run_on_your_server
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
  end

  it 'DocSpace "Learn more" link works' do
    result_page = @all_enterprise_solutions.click_docspace_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceMainPage
  end

  it '"Download desktop editors" link works' do
    result_page = @all_enterprise_solutions.click_download_desktop
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it 'Docs "Learn more" link works' do
    result_page = @all_enterprise_solutions.click_docs_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteForBusinessDocsEnterpriseEdition
  end

  it 'Docs "See prices" link works' do
    result_page = @all_enterprise_solutions.click_docs_see_prices
    expect(result_page).to be_a TestingSiteOnlyoffice::SitePriceDocsEnterprise
  end

  it 'Workspace "Try now" link works' do
    result_page = @all_enterprise_solutions.click_workspace_try_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeWorkspaceEnterprise
  end

  it 'Workspace "See prices" link works' do
    result_page = @all_enterprise_solutions.click_workspace_see_prices
    expect(result_page).to be_a TestingSiteOnlyoffice::SitePricingWorkSpace
  end

  it 'Workspace "Learn more" link works' do
    result_page = @all_enterprise_solutions.click_workspace_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteEnterpriseEdition
  end

  it 'Desktop "Download now" link works' do
    result_page = @all_enterprise_solutions.click_desktop_download_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
  end

  it 'Desktop "Learn more" link works' do
    result_page = @all_enterprise_solutions.click_desktop_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesDesktop
  end

  it 'Mobile "Download now" link works' do
    result_page = @all_enterprise_solutions.click_mobile_download_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteMobileApps
  end

  it 'Mobile "iOS Learn more" link works' do
    result_page = @all_enterprise_solutions.click_mobile_ios_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesIos
  end

  it 'Mobile "Android Learn more" link works' do
    result_page = @all_enterprise_solutions.click_mobile_android_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesAndroid
  end
end
