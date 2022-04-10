# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners submit request' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @submit_request = site_home_page.click_link_on_toolbar(:partners_submit_request)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners submit request] Go to submit request' do
    expect(@submit_request).to be_a TestingSiteOnlyoffice::SitePartnersRequest
  end
end
