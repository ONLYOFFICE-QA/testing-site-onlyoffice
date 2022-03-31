# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Help center' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @help_center = site_home_page.click_link_on_toolbar(:about_help_center)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Help center] Go to help center' do
    expect(@help_center).to be_a TestingSiteOnlyoffice::SiteHelpCenter
  end

  it '[Help center] Help center site map visible' do
    expect(@help_center.help_center_site_map_visible?).to be(true)
  end
end
