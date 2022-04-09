# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners resellers' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @find_partners = site_home_page.click_link_on_toolbar(:partners_find_partners)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners find] Go to become partners' do
    expect(@find_partners.check_become_partner_request?).to be_a TestingSiteOnlyoffice::SitePartnersRequest
  end

  it '[Partners find] Go to submit request' do
    expect(@find_partners.check_button_submit_request?).to be_a TestingSiteOnlyoffice::SitePartnersRequest
  end
end
