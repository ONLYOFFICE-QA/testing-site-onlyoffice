# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners affiliates' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @affiliates = site_home_page.click_link_on_toolbar(:partners_affiliates)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners affiliates] Go to partners affiliates' do
    expect(@affiliates).to be_a TestingSiteOnlyoffice::SitePartnersAffiliates
  end

  it '[Partners affiliates] Transition to affiliates' do
    expect(@affiliates.transition_to_affiliates?).to be(true)
  end

  it '[Partners affiliates] Registration to affiliates' do
    expect(@affiliates.registration_to_affiliates?).to be(true)
  end

  it '[Partners affiliates] Sign in to affiliates' do
    expect(@affiliates.sign_in_to_affiliates?).to be(true)
  end
end
