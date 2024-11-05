# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Developers - Conversion API' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @conversion_api = site_home_page.click_link_on_toolbar(:for_developers_conversion_api)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it '[Developers] [Conversion API] "Get started" button works' do
    @conversion_api.get_started
    expect(@conversion_api.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::OVERVIEW_API_ONLYOFFICE_TITLE)
  end

  it '[Developers] [Conversion API] "Popular formats" link works' do
    @conversion_api.formats_link
    expect(@conversion_api.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::CONVERSION_API_ONLYOFFICE_TITLE)
  end

  it '[Developers] [Conversion API] "Api Documentation" link works' do
    @conversion_api.api_documentation_link
    expect(@conversion_api.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::CONVERSION_API_ONLYOFFICE_TITLE)
  end

  it '[Developers] [Conversion API] "Online Converter" link works' do
    result_page = @conversion_api.click_online_converter_link
    expect(result_page).to be_a TestingSiteOnlyoffice::ConvertPage
  end

  it '[Developers] [Conversion API] "Security measures" link works' do
    result_page = @conversion_api.click_security_measures_link
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesSecurity
  end
end
