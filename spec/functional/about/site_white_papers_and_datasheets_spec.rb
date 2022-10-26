# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)

describe 'White papers and datasheets' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @white_paper_page = site_home_page.click_link_on_toolbar(:about_white_papers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[White papers] Number of white paper modules didn't change" do
    expect(@white_paper_page.white_papers_names).to eq(TestingSiteOnlyoffice::SiteData.white_papers.keys)
  end

  it "[White papers] Number of datasheets didn't change" do
    expect(@white_paper_page.datasheets_names).to eq(TestingSiteOnlyoffice::SiteData.datasheets.keys)
  end

  it '[White papers] Search field works' do
    @white_paper_page.about_search('nextcloud')
    expect(@white_paper_page).to be_white_paper_block_visible('onlyoffice_docs_for_nextcloud')
    expect(@white_paper_page).not_to be_white_paper_block_visible('onlyoffice_docs_for_owncloud')
    expect(@white_paper_page).not_to be_white_paper_block_visible('end_to_end_document_encryption')
  end

  it '[White papers] Filter `All` works' do
    @white_paper_page.change_left_filter(:'White papers')
    expect(@white_paper_page).to be_white_paper_block_visible('end_to_end_document_encryption')
    expect(@white_paper_page).not_to be_white_paper_block_visible('onlyoffice_docs_for_owncloud')
    @white_paper_page.change_left_filter(:Datasheets)
    expect(@white_paper_page).not_to be_white_paper_block_visible('end_to_end_document_encryption')
    expect(@white_paper_page).to be_white_paper_block_visible('onlyoffice_docs_for_owncloud')
    @white_paper_page.change_left_filter(:All)
    expect(@white_paper_page).to be_white_paper_block_visible('end_to_end_document_encryption')
    expect(@white_paper_page).to be_white_paper_block_visible('onlyoffice_docs_for_owncloud')
  end

  TestingSiteOnlyoffice::SiteData.white_papers_and_datasheets.each_key do |white_paper_datasheet|
    it "[White papers] Check #{white_paper_datasheet} mail request confirmation and file download" do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      @white_paper_page.open_and_send_request_white_paper(white_paper_datasheet.to_s)
      file_name = TestingSiteOnlyoffice::SiteData.white_papers_and_datasheets[white_paper_datasheet]
      expect(@white_paper_page).to be_file_downloaded(file_name)
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(language: config.language,
                                                                                   pattern: 'white_paper',
                                                                                   module: 'WebStudio',
                                                                                   search: white_paper_datasheet.to_s,
                                                                                   mail: partner_email,
                                                                                   move_out: true)).to be_truthy
    end
  end
end
