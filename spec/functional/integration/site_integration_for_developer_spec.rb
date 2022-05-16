# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Integration for developer' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @for_developer = site_home_page.click_link_on_toolbar(:integrations_for_developers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[For developer] Go to integration for developer' do
    expect(@for_developer).to be_a TestingSiteOnlyoffice::SiteProductsDeveloperEdition
  end
end
