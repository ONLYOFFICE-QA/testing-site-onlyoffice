# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Cloud Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @cloud_edition = site_home_page.click_link_on_toolbar(:products_workspace_cloud_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Workspace edition] Go to cloud edition' do
    expect(@cloud_edition).to be_a TestingSiteOnlyoffice::SiteCloudEdition
  end
end
