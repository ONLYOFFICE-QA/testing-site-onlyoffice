# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site features workspace calendar' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @calendar = site_home_page.click_link_on_toolbar(:products_workspace_calendar)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][Products][CRM]'Check select section calendar" do
    expect(@calendar.check_select?('calendar')).to be true
  end
end
