# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe '[Resources] [For translators]' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_for_translators = site_home_page.click_link_on_toolbar(:about_translators)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Resources] [For translators] Go to For translators' do
    expect(@about_for_translators).to be_a TestingSiteOnlyoffice::SiteAboutHelpCenter
  end
end
