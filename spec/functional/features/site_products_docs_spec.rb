# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Products Docs' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docs_page = site_home_page.click_link_on_toolbar(:features_document_overview)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteFeaturesDocsOverview::FEATURES_LINKS.each do |feature_key, feature_info|
    it_behaves_like 'checking_editors_links', feature_key, feature_info
  end

  it '[Site Products] [Docs] "Get it now" button works' do
    result_page = @docs_page.click_get_it_now_top
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site Products] [Docs] "See it in action" button works' do
    result_page = @docs_page.click_see_it_action
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesSeeItInAction
  end

  it '[Site Products] [Docs] "Find the plugins" button works' do
    result_page = @docs_page.click_find_the_plugins
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesMarketplace
  end

  it '[Site Products] [Docs] "Security - learn more" button works' do
    result_page = @docs_page.click_security_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesSecurity
  end

  it '[Site Products] [Docs] "DocSpace sign up" button works' do
    result_page = @docs_page.click_docspace_start_free
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site Products] [Docs] "40+ ready integrations" button works' do
    result_page = @docs_page.click_ready_integrations
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteConnectorsOnlyoffice
  end

  it '[Site Products] [Docs] "Get docs now" button works' do
    result_page = @docs_page.click_get_docs_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site Products] [Docs] "Platform you build - learn more" button works' do
    result_page = @docs_page.click_integrate_learn_more
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition
  end

  it '[Site Products] [Docs] "Download desktop" button works' do
    result_page = @docs_page.click_download_pc
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
  end

  it '[Site Products] [Docs] "Install mobile" button works' do
    result_page = @docs_page.click_install_mobile
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteMobileApps
  end
end
