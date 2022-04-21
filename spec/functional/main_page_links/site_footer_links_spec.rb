# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
site_home_page, test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)

describe 'Help center footer links' do
  after do |example|
    test_manager.add_result(example, test)
  end

  after(:all) { test.webdriver.quit }

  TestingSiteOnlyoffice::SiteData.footer_links.each do |section_title, titles|
    titles.each do |title|
      it "[Site] `#{title}` link of `#{section_title}` footer section works" do
        pending('Link `https://www.instagram.com/the_onlyoffice/` answered with 405') if title == ('Follow us on Instagram' || 'Follow us on Medium')
        pending('Link `https://www.linkedin.com/company/ascensio-system-sia/` answered with 999') if title == 'Follow us on LinkedIn'
        expect(site_home_page).to be_site_footer_link_alive(section_title, title)
      end
    end
  end
end
