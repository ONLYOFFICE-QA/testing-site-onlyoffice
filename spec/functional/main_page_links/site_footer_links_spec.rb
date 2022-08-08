# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Help center footer links' do
  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteData.footer_links.each do |section_title, titles|
    titles.each do |title|
      it "[Site] `#{title}` link of `#{section_title}` footer section works" do
        site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
        pending('Link `https://www.linkedin.com/company/ascensio-system-sia/` answered with 999') if title == 'Follow us on LinkedIn'
        pending('Instagram is blocking access from autotests with 405 error') if title == 'Follow us on Instagram'
        expect(site_home_page).to be_site_footer_link_alive(section_title, title)
      end
    end
  end
end
