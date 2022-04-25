# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Plone' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @integration = site_home_page.click_link_on_toolbar(:integrations_plone)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Plone] Go to plone' do
    expect(@integration).to be_a TestingSiteOnlyoffice::SitePlone
  end

  describe 'Pick price' do
    it_behaves_like 'integration_pick_price' do
      let(:integration_pick_price) { @integration }
    end
  end
end
