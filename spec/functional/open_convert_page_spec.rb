# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Convert page' do
  before do
    @site_main_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it 'Open convert page' do
    convert_page = @site_main_page.open_convert_page
    expect(convert_page).to be_file_input_present
  end
end
