# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Enterprise Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @enterprise_edition = site_home_page.click_link_on_toolbar(:products_docs_enterprise_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Enterprise Edition] Go to get it now' do
    expect(@enterprise_edition.check_button_get_it_now?).to be_a TestingSiteOnlyoffice::SiteDocsEnterprise
  end

  it '[Enterprise Edition] Go to request_demo' do
    expect(@enterprise_edition.check_button_request_demo?).to be_a TestingSiteOnlyoffice::SiteOrderDemo
  end

  it '[Enterprise Edition] Go to document_editing' do
    expect(@enterprise_edition.check_button_document_editing?).to be_a TestingSiteOnlyoffice::SiteProductsDocumentEditor
  end

  it '[Enterprise Edition] Go to spreadsheet_editing' do
    expect(@enterprise_edition.check_button_spreadsheet_editing?).to be_a TestingSiteOnlyoffice::SiteProductsSpreadsheetEditor
  end

  it '[Enterprise Edition] Go to presentation_editing' do
    expect(@enterprise_edition.check_button_presentation_editing?).to be_a TestingSiteOnlyoffice::SiteProductsPresentationEditor
  end

  it '[Enterprise Edition] Go to form_creator' do
    expect(@enterprise_edition.check_button_form_creator?).to be_a TestingSiteOnlyoffice::SiteProductsFormCreator
  end

  it '[Enterprise Edition] Go to desktop_apps' do
    expect(@enterprise_edition.check_button_desktop_apps?).to be_a TestingSiteOnlyoffice::SiteDesktopApps
  end

  it '[Enterprise Edition] Go to mobile_apps' do
    expect(@enterprise_edition.check_button_mobile_apps?).to be_a TestingSiteOnlyoffice::SiteMobileApps
  end

  it '[Enterprise Edition] Go to self_hosted' do
    expect(@enterprise_edition.check_button_self_hosted?).to be_a TestingSiteOnlyoffice::SiteDocsEnterprise
  end

  it '[Enterprise Edition] Go to amazon' do
    expect(@enterprise_edition.check_link_business_platform?(:amazon)).to be true
  end

  it '[Enterprise Edition] Go to univention' do
    expect(@enterprise_edition.check_link_business_platform?(:univention)).to be true
  end
end
