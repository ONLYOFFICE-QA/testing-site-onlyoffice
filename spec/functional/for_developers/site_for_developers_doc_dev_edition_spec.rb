# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Developer Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @developer_edition = site_home_page.click_link_on_toolbar(:for_developers_doc_dev_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Developer Edition] Go to get it now' do
    expect(@developer_edition.check_button_get_it_developer?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to request_demo' do
    expect(@developer_edition.check_button_developer_see_in_action?).to be_a TestingSiteOnlyoffice::SiteFeaturesSeeItInAction
  end

  it '[Developer Edition] Go to macros_and_plugins' do
    expect(@developer_edition.check_button_macros_and_plugins?).to be true
  end

  it '[Developer Edition] Go to cross_browser_compatibility' do
    expect(@developer_edition.check_button_cross_browser_compatibility?).to be_a TestingSiteOnlyoffice::SiteCompareSuites
  end

  it '[Developer Edition] Go to check_button_easy_deployment' do
    expect(@developer_edition.check_button_easy_deployment?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to check_button_integration_api' do
    expect(@developer_edition.check_button_integration_api?).to be true
  end

  it '[Developer Edition] Go to check_button_wopi_support' do
    expect(@developer_edition.check_button_wopi_support?).to be_a TestingSiteOnlyoffice::SiteWOPIComparison
  end
end