# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs enterprise' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @mail = IredMailHelper.new(username: 'avangate-buy-product@qamail.teamlab.info',
                               password: @test.private_data['mail_avangate-buy-product_pass'])
    @mail.delete_all_messages
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][PricingDocsEnterprise] Try it free download docs' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    connectors = pricing_page.click_try_free_button
    expect(connectors.title_docs_enterprise).to eq('ONLYOFFICE Docs Enterprise')
  end
end
