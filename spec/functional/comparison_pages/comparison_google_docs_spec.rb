# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Comparison - ONLYOFFICE Docs vs Google Docs' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @google_docs_comparison = site_home_page.click_oo_docs_vs_google_docs
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Comparison][Google Docs] Watch presentation' do
    @google_docs_comparison.click_watch_presentation
    expect(@google_docs_comparison.check_opened_file_name).to eq 'Comparison with Google Docs.pptx'
  end

  it '[Comparison][Google Docs] Read instruction' do
    @google_docs_comparison.click_read_instruction
    expect(@google_docs_comparison.check_opened_file_name).to eq 'How to compare online editors.pdf'
  end

  it '[Comparison][Google Docs] "Get onlyoffice docs" now button works' do
    result_page = @google_docs_comparison.click_get_onlyoffice_docs
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Comparison][Google Docs] "Try in the cloud" button works' do
    result_page = @google_docs_comparison.click_try_in_the_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end
end
