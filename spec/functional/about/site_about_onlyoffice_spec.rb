# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Customer stories' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @customer_stories = site_home_page.click_link_on_toolbar(:about_onlyoffice)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Customer stories] Go to onlyoffice docs' do
    expect(@customer_stories.click_onlyoffice_docs).to be_a TestingSiteOnlyoffice::SiteProductsDocs
  end

  it '[Customer stories] Go to egistration_cloud' do
    expect(@customer_stories.click_registration_cloud).to be_a TestingSiteOnlyoffice::SiteSignUp
  end

  it '[Customer stories] Go to customer_stories' do
    expect(@customer_stories.click_customer_stories).to be_a TestingSiteOnlyoffice::SiteCustomerStories
  end
end
