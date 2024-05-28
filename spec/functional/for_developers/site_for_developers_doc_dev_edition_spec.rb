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

  describe 'Editors pending due to issue', pending: 'Waiting for fix from Irina' do
    TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition::FEATURES_LINKS.each do |feature_key, feature_info|
      it_behaves_like 'checking_editors_links', feature_key, feature_info do
        let(:page) { @developer_edition }
      end
    end
  end

  it '[Developer Edition] Go to Docbuilder' do
    expect(@developer_edition.click_document_builder).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocBuilder
  end

  it '[Developer Edition] Go to Conversion API' do
    expect(@developer_edition.click_document_conversion).to be_a TestingSiteOnlyoffice::SiteForDevelopersConversionAPI
  end

  it '[Developer Edition] Go to macros_and_plugins' do
    @developer_edition.click_button_macros_and_plugins
    expected_title = 'Overview - ONLYOFFICE Api Documentation'
    expect(@developer_edition.check_opened_page_title(switch_tab: false)).to eq(expected_title)
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
    expect(@developer_edition.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::AWS_MARKETPLACE_TITLE)
  end

  it '[Developer Edition] Go to get started / Alibaba image' do
    @developer_edition.click_button_get_started_alibaba_image
    expect(@developer_edition.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::ALIBABA_MARKETPLACE_TITLE)
  end
end
