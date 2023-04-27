# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Enterprise Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @enterprise_edition = site_home_page.click_link_on_toolbar(:for_enterprises).open_docs_enterprise
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][For Business Enterprise Edition] Go to get it now' do
    expect(@enterprise_edition.check_button_get_it_now?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site][For Business Enterprise Edition] Go to see it in action' do
    expect(@enterprise_edition.check_button_see_it_in_action?).to be_a TestingSiteOnlyoffice::SiteFeaturesSeeItInAction
  end

  it '[Site][For Business Enterprise Edition] Go to document_editing' do
    expect(@enterprise_edition.check_button_document_editing?).to be_a TestingSiteOnlyoffice::SiteFeaturesDocumentEditor
  end

  it '[Site][For Business Enterprise Edition] Go to spreadsheet_editing' do
    expect(@enterprise_edition.check_button_spreadsheet_editing?).to be_a TestingSiteOnlyoffice::SiteFeaturesSpreadsheetEditor
  end

  it '[Site][For Business Enterprise Edition] Go to presentation_editing' do
    expect(@enterprise_edition.check_button_presentation_editing?).to be_a TestingSiteOnlyoffice::SiteFeaturesPresentationEditor
  end

  it '[Site][For Business Enterprise Edition] Go to form_creator' do
    expect(@enterprise_edition.check_button_form_creator?).to be_a TestingSiteOnlyoffice::SiteFeaturesFormCreator
  end

  it '[Site][For Business Enterprise Edition] Go to desktop_apps' do
    expect(@enterprise_edition.check_button_desktop_apps?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
  end

  it '[Site][For Business Enterprise Edition] Go to mobile_apps' do
    expect(@enterprise_edition.check_button_mobile_apps?).to be_a TestingSiteOnlyoffice::SiteMobileApps
  end

  it '[Site][For Business Enterprise Edition] Go to docs-as-a-service' do
    expect(@enterprise_edition.check_button_docs_registration?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsRegistration
  end

  it '[Site][For Business Enterprise Edition] Go to self_hosted' do
    expect(@enterprise_edition.check_button_self_hosted?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site][For Business Enterprise Edition] Go to amazon' do
    expect(@enterprise_edition).to be_check_link_amazon
  end
end
