# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'About onlyoffice' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_onlyoffice = site_home_page.click_link_on_toolbar(:about_onlyoffice)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[About onlyoffice] Go to onlyoffice docs' do
    expect(@about_onlyoffice.click_onlyoffice_docs).to be_a TestingSiteOnlyoffice::SiteProductsDocs
  end

  it '[About onlyoffice] Go to egistration_cloud' do
    expect(@about_onlyoffice.click_registration_cloud).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeSignUp
  end

  it '[About onlyoffice] Go to customer_stories' do
    expect(@about_onlyoffice.click_customer_stories).to be_a TestingSiteOnlyoffice::SiteAboutCustomerStories
  end
end
