# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site toolbar actions - request a call' do
  before { @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config) }

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Request call button open a callback form' do
    callback_form = @site_home_page.click_request_call
    expect(callback_form).to be_a TestingSiteOnlyoffice::SiteCallback
  end
end
