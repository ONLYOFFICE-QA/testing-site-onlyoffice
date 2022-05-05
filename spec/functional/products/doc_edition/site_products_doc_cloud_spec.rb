# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Cloud Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @cloud_edition = site_home_page.click_link_on_toolbar(:products_docs_cloud_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Cloud Edition] Go to cloud_edition' do
    expect(@cloud_edition).to be_a TestingSiteOnlyoffice::SiteProductsCloudEdition
  end

  it '[Cloud Edition] Go to document_editing' do
    expect(@cloud_edition.check_button_document_editing?).to be_a TestingSiteOnlyoffice::SiteProductsDocumentEditor
  end

  it '[Cloud Edition] Go to spreadsheet_editing' do
    expect(@cloud_edition.check_button_spreadsheet_editing?).to be_a TestingSiteOnlyoffice::SiteProductsSpreadsheetEditor
  end

  it '[Cloud Edition] Go to presentation_editing' do
    expect(@cloud_edition.check_button_presentation_editing?).to be_a TestingSiteOnlyoffice::SiteProductsPresentationEditor
  end

  it '[Cloud Edition] Go to form_creator' do
    expect(@cloud_edition.check_button_form_creator?).to be_a TestingSiteOnlyoffice::SiteProductsFormCreator
  end

  it '[Cloud Edition] Go to pre_order' do
    expect(@cloud_edition.check_button_pre_order?).to be_a TestingSiteOnlyoffice::DocsRegistrationPage
  end

  it '[Cloud Edition] Go to other_connectors' do
    expect(@cloud_edition.check_button_other_connectors?).to be_a TestingSiteOnlyoffice::SiteProductsConnectorsOnlyoffice
  end
end
