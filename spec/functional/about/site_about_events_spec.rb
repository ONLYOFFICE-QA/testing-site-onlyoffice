# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'About events' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @events = site_home_page.click_link_on_toolbar(:about_events)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[About events] Go to events' do
    expect(@events).to be_a TestingSiteOnlyoffice::SiteAboutEvents
  end
end
