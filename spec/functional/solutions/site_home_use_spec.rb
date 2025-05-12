# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Document Builder download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @home_use_page = site_home_page.open_home_use_page
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][HomeUse]Button "Download now" works for desktop editors works' do
    download_desktop_page = @home_use_page.download_desktop_editors
    expect(download_desktop_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
  end

  it '[Site][HomeUse]Button "Learn more" works for desktop editors works' do
    product_desktop_page = @home_use_page.click_learn_more_desktop_editors
    expect(product_desktop_page).to be_a TestingSiteOnlyoffice::SiteFeaturesDesktop
  end

  it '[Site][HomeUse]Button "Get it now" works for self-hosted editors' do
    download_editors_page = @home_use_page.get_it_now_self_hosted_editors
    expect(download_editors_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site][HomeUse]Button "See all connectors" works' do
    download_editors_page = @home_use_page.click_see_all_integrations
    expect(download_editors_page).to be_a TestingSiteOnlyoffice::SiteConnectorsOnlyoffice
  end

  it '[Site][HomeUse]Button "Download" works for self-hosted productivity apps' do
    download_workspace_page = @home_use_page.download_self_hosted_productivity_apps
    expect(download_workspace_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeWorkspaceEnterprise
  end

  it '[Site][HomeUse]Button "Create online office" works' do
    personal_page = @home_use_page.open_docspace_registration
    expect(personal_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site][HomeUse]Button "Download on the App Store" works' do
    page_title = @home_use_page.click_download_on_app_store
    expect(page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_APP_STORE)
  end

  it '[Site][HomeUse]Button "Get it on Google Play" works' do
    page_title = @home_use_page.click_download_on_google_play
    expect(page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_GOOGLE)
  end
end
