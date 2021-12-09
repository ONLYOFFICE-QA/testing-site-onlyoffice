# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Customer stories' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @awards = site_home_page.click_link_on_toolbar(:about_awards)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Awards] Go to awards' do
    expect(@awards).to be_a TestingSiteOnlyoffice::SiteAwards
  end

  it '[Awards] Go to registration' do
    expect(@awards.click_use_cloud).to be_a TestingSiteOnlyoffice::SiteSignUp
  end
end
