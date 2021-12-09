# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Customer stories' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @customer_stories = site_home_page.click_link_on_toolbar(:about_customers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Customer stories] Go to customer_stories' do
    expect(@customer_stories).to be_a TestingSiteOnlyoffice::SiteCustomerStories
  end
end
