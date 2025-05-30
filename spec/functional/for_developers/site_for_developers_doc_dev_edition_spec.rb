# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'For Developers Developer Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @developer_edition = site_home_page.click_link_on_toolbar(:for_developers_doc_dev_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it '[Developer Edition] Go to Docbuilder' do
    expect(@developer_edition.click_document_builder).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocBuilder
  end

  it '[Developer Edition] Go to macros_and_plugins' do
    @developer_edition.click_button_macros_and_plugins
    expected_title = 'Online editors to develop your web solution | ONLYOFFICE'
    expect(@developer_edition.check_opened_page_title(switch_tab: false)).to eq(expected_title)
  end

  it '[Developer Edition] Go to check_button_easy_deployment' do
    expect(@developer_edition.check_button_easy_deployment?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to check_button_external_access' do
    @developer_edition.click_button_external_access
    expect(@developer_edition.check_opened_page_title(switch_tab: false)).to eq(TestingSiteOnlyoffice::SiteDownloadData::AUTOMATION_API_ONLYOFFICE_TITLE)
  end

  it '[Developer Edition] Go to get started / self-hosted' do
    expect(@developer_edition.check_button_get_started_self_hosted?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developer Edition] Go to get started / Amazone machine' do
    @developer_edition.click_button_get_started_amazone_machine
    expect(@developer_edition.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::AWS_MARKETPLACE_TITLE)
  end

  it '[Developer Edition] Go to get started / Alibaba image' do
    @developer_edition.click_button_get_started_alibaba_image
    expect(@developer_edition.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::ALIBABA_MARKETPLACE_TITLE)
  end
end
