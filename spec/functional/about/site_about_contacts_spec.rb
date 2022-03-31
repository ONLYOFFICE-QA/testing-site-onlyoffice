# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Contacts' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @awards = site_home_page.click_link_on_toolbar(:about_contacts)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Contacts] Go to contacts' do
    expect(@awards).to be_a TestingSiteOnlyoffice::SiteContacts
  end

  it '[Contacts] Check region office' do
    expect(@awards.all_offices_present?).to be(true)
  end
end
