# frozen_string_literal: true

AWS_MARKETPLACE_TITLE = 'AWS Marketplace: Ascensio Systems Inc'
ALIBABA_MARKETPLACE_TITLE = 'Ascensio System Ltd. - Alibaba Cloud'
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

  it '[Developer Edition] Go to text document editing / learn more' do
    expect(@developer_edition.click_text_document_editing).to be_a TestingSiteOnlyoffice::SiteFeaturesDocumentEditor
  end

  it '[Developer Edition] Go to get it now' do
    expect(@developer_edition.check_button_get_it_developer?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to see it in action' do
    expect(@developer_edition.check_button_developer_see_in_action?).to be_a TestingSiteOnlyoffice::SiteFeaturesSeeItInAction
  end

  it '[Developer Edition] Go to spreadsheet editing / learn more' do
    expect(@developer_edition.click_spreadsheet_editing).to be_a TestingSiteOnlyoffice::SiteFeaturesSpreadsheetEditor
  end

  it '[Developer Edition] Go to digital form building / learn more' do
    expect(@developer_edition.click_digital_form_building).to be_a TestingSiteOnlyoffice::SiteFeaturesFormCreator
  end

  it '[Developer Edition] Go to presentation editing / learn more' do
    expect(@developer_edition.click_presentation_editing).to be_a TestingSiteOnlyoffice::SiteFeaturesPresentationEditor
  end

  it '[Developer Edition] Go to pdf editing / learn more' do
    expect(@developer_edition.click_pdf_editing_and_filling).to be_a TestingSiteOnlyoffice::SiteFeaturesPDFReaderConverter
  end

  it '[Developer Edition] Go to document building / learn more' do
    expect(@developer_edition.click_document_building).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocBuilder
  end

  it '[Developer Edition] Go to document conversion / learn more' do
    expect(@developer_edition.click_document_conversion).to be_a TestingSiteOnlyoffice::SiteForDevelopersConversionAPI
  end

  it '[Developer Edition] Go to e-book creation / learn more' do
    expect(@developer_edition.click_e_book_creation).to be_a TestingSiteOnlyoffice::SiteFeaturesEBookCreator
  end

  it '[Developer Edition] Go to macros_and_plugins' do
    @developer_edition.click_button_macros_and_plugins
    expect(@developer_edition.check_opened_page_title(switch_tab: false)).to eq(TestingSiteOnlyoffice::SiteDownloadData::OVERVIEW_API_ONLYOFFICE_TITLE)
  end

  it '[Developer Edition] Go to cross_browser_compatibility' do
    expect(@developer_edition.check_button_cross_browser_compatibility?).to be_a TestingSiteOnlyoffice::SiteCompareSuites
  end

  it '[Developer Edition] Go to check_button_easy_deployment' do
    expect(@developer_edition.check_button_easy_deployment?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to check_button_integration_api' do
    @developer_edition.click_button_external_access
    expect(@developer_edition.check_opened_page_title(switch_tab: false)).to eq(TestingSiteOnlyoffice::SiteDownloadData::EXTERNAL_ACCES_API_ONLYOFFICE_TITLE)
  end

  it '[Developer Edition] Go to check_button_wopi_support' do
    expect(@developer_edition.check_button_wopi_support?).to be_a TestingSiteOnlyoffice::SiteWOPIComparison
  end

  it '[Developer Edition] Go to get started / self-hosted' do
    expect(@developer_edition.check_button_get_started_self_hosted?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to get started / Amazone machine' do
    @developer_edition.click_button_get_started_amazone_machine
    expect(@developer_edition.check_opened_page_title).to eq(AWS_MARKETPLACE_TITLE)
  end

  it '[Developer Edition] Go to get started / Alibaba image' do
    @developer_edition.click_button_get_started_alibaba_image
    expect(@developer_edition.check_opened_page_title).to eq(ALIBABA_MARKETPLACE_TITLE)
  end
end
