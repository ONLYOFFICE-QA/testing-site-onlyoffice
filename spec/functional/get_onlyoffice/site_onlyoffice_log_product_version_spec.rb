# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Сhecking for a product version logging error' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @download_commercial_page = site_home_page.click_link_on_toolbar(:onlyoffice_docs_download)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it_behaves_like 'сhecking_logger_errors' do
    let(:сhecking_logger_errors) { @download_commercial_page }
  end
end
