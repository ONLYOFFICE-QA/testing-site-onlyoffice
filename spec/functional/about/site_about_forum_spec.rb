# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe '[Resources] [Forum]' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_forum = site_home_page.click_link_on_toolbar(:about_forum)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Resources] [Forum] Go to Forum' do
    expect(@about_forum).to be_a TestingSiteOnlyoffice::SiteAboutForum
  end
end
