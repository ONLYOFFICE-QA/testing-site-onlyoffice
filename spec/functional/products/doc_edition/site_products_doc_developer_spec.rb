# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Developer Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @developer_edition = site_home_page.click_link_on_toolbar(:products_docs_developer_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Developer Edition] Go to get it now' do
    expect(@developer_edition.check_button_get_it_developer?).to be_a TestingSiteOnlyoffice::SiteDocsDeveloper
  end

  it '[Developer Edition] Go to request_demo' do
    expect(@developer_edition.check_button_developer_request_demo?).to be_a TestingSiteOnlyoffice::SiteOrderDemo
  end

  it '[Developer Edition] Go to document_editing' do
    expect(@developer_edition.check_button_document_editing?).to be_a TestingSiteOnlyoffice::SiteProductsDocumentEditor
  end

  it '[Developer Edition] Go to spreadsheet_editing' do
    expect(@developer_edition.check_button_spreadsheet_editing?).to be_a TestingSiteOnlyoffice::SiteProductsSpreadsheetEditor
  end

  it '[Developer Edition] Go to presentation_editing' do
    expect(@developer_edition.check_button_presentation_editing?).to be_a TestingSiteOnlyoffice::SiteProductsPresentationEditor
  end

  it '[Developer Edition] Go to form_creator' do
    expect(@developer_edition.check_button_form_creator?).to be_a TestingSiteOnlyoffice::SiteProductsFormCreator
  end

  it '[Developer Edition] Go to format_compatibility' do
    expect(@developer_edition.check_button_format_compatibility?).to be true
  end

  it '[Developer Edition] Go to editing_functionality' do
    expect(@developer_edition.check_button_editing_functionality?).to be true
  end

  it '[Developer Edition] Go to collaborative_features' do
    expect(@developer_edition.check_button_collaborative_features?).to be true
  end

  it '[Developer Edition] Go to macros_and_plugins' do
    expect(@developer_edition.check_button_macros_and_plugins?).to be true
  end

  it '[Developer Edition] Go to cross_browser_compatibility' do
    expect(@developer_edition.check_button_cross_browser_compatibility?).to be_a TestingSiteOnlyoffice::SiteCompareSuites
  end

  it '[Developer Edition] Go to supported_programming_languages' do
    expect(@developer_edition.check_button_supported_programming_languages?).to be true
  end

  it '[Developer Edition] Go to check_button_easy_deployment' do
    expect(@developer_edition.check_button_easy_deployment?).to be_a TestingSiteOnlyoffice::SiteDocsDeveloper
  end

  it '[Developer Edition] Go to check_button_integration_api' do
    expect(@developer_edition.check_button_integration_api?).to be true
  end

  it '[Developer Edition] Go to check_button_highest_security' do
    expect(@developer_edition.check_button_highest_security?).to be_a TestingSiteOnlyoffice::SiteProductsSecurity
  end

  it '[Developer Edition] Go to check_button_wopi_support' do
    expect(@developer_edition.check_button_wopi_support?).to be_a TestingSiteOnlyoffice::SiteWOPIComparison
  end
end
