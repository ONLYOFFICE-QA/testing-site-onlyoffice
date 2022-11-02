# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Personal' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @personal = site_home_page.click_link_on_toolbar(:products_personal)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Personal] Go to personal main page' do
    expect(@personal).to be_a TestingSiteOnlyoffice::PersonalMainPage
  end
end
