# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing DocSpace' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Try it free' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
    expect(pricing_page.click_try_free_button).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
  end

  it_behaves_like 'pricing_buy_page', 'PricingDocSpace',
                  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level],
                  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:number_connection_docspace] do
    let(:pricing_page) do
      pricing_docspace_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
      pricing_docspace_page.click_enterprise_on_premises
      pricing_docspace_page
    end
  end
end
