# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Webinars' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @webinars = site_home_page.click_link_on_toolbar(:about_webinars)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Webinars] Go to Webinars' do
    expect(@webinars).to be_a TestingSiteOnlyoffice::SiteWebinars
  end
end
