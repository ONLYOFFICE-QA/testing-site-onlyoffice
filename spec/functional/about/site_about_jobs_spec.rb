# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Jobs' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @jobs = site_home_page.click_link_on_toolbar(:about_jobs)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Jobs] Go to Jobs' do
    expect(@jobs).to be_a TestingSiteOnlyoffice::SiteAboutJobs
  end
end
