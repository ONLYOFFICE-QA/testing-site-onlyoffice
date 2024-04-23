# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing Docspace Family pack' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_docspace_family_page = @site_home_page.click_link_on_toolbar(:pricing_docspace_family_pack)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][DocSpace Family Pack] Try it free link works' do
    result_page = @pricing_docspace_family_page.click_try_free_docspace
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
  end

  it '[Site][Pricing][DocSpace Family Pack] Buy now button works' do
    total_price = @pricing_docspace_family_page.total_price_number.to_i
    payment_page = @pricing_docspace_family_page.go_to_payment_from_pricing_page(@pricing_docspace_family_page.buy_now_button_element, test_purchase: true)
    expect(payment_page.total_amount_without_tax).to eq(total_price)
  end
end
