# frozen_string_literal: true

require_relative '../modules/site_toolbar'

module TestingSiteOnlyffice
  class SiteHelpCenter
    attr_accessor :instance

    include PageObject
    include SiteToolbar

    # link(:teamLab_modules, :xpath => '//*[@id="switcherMenu"]/span[1]')
    link(:documentation_type, xpath: '//*[@id="switcherMenu"]/span[2]')

    link(:products_documents, xpath: '//*[@id="link_040"]')
    link(:documents_getting_started, xpath: '//*[@id="productsMainContent"]//a[contains(@href,"gettingstarted/documents")]')
    text_field(:search, xpath: '//*[@id="txtSearch"]')
    link(:first_result_search, xpath: '//*[@class="searchResult"]/ol/li[1]/h2/a')
    link(:read_more_user_guides, xpath: '//*[@id="itemsMainContent"]/div[1]/a[5]')

    link(:getting_started, xpath: '//*[@id="itemsListMenu"]/li[1]/a')
    link(:user_guides, xpath: '//*[@id="itemsListMenu"]/li[2]/a')
    link(:video_guides, xpath: '//*[@id="itemsListMenu"]/li[3]/a')
    link(:tips_tricks, xpath: '//*[@id="itemsListMenu"]/li[4]/a')
    link(:troubleshooting, xpath: '//*[@id="itemsListMenu"]/li[5]/a')
    link(:teamLab_co_authors, xpath: '//*[@id="productsListMenu"]/parent::*/ul[5]/li[1]/a')
    link(:glossary, xpath: '//*[@id="productsListMenu"]/parent::*/ul[5]/li[2]/a')
    link(:faq, xpath: '//*[@id="productsListMenu"]/parent::*/ul[5]/li[3]/a')
    link(:read_print, xpath: '//*[@id="productsListMenu"]/parent::*/ul[5]/li[4]/a')

    link(:getting_started_main_page, xpath: '//*[@id="switcherMenu"]/parent::*//a[contains(@href,"/gettingstarted.aspx")]')
    link(:portal_configuration, xpath: '//*[@id="switcherMenu"]/parent::*//a[contains(@href,"/gettingstarted/configuration.aspx")]')
    link(:icon_documents_getting_started, xpath: '//*[contains(@src,"/images/Help/Documents")]')
    link(:read_more_documents_getting_started, xpath: '//*[@id="toggleMenuEditors"]/div[1]/div/div[1]/a')
    link(:show_documents_getting_started, xpath: '//*[@id="link_020"]/parent::*/parent::div/span[1]')
    link(:hide_documents_getting_started, xpath: '//*[@id="link_020"]/parent::*/parent::div/span[2]')
    link(:overview_documents_getting_started, xpath: '//*[contains(@href,"documents.aspx#Overview_block")]')

    link(:title_documents_getting_started, xpath: '//*[@id="link_020"]')
    link(:article_user_guides, xpath: '//*[@id="link_047"]')
    span(:first_title_video_guides, xpath: '//*[@id="video-guides-15"]/a/span[2]/span')
    link(:article_tips_tricks, xpath: '//*[@id="link_058"]')
    link(:documents_troubleshooting, xpath: '//*[@id="documents"]/parent::*/h2/a')
    link(:first_videos_teamLab_co_authors, xpath: '//*[@id="link_1"]')
    link(:first_link_glossary, xpath: '//*[@id="gloss_a_block"]/p[2]/b[1]')
    link(:first_link_faq, xpath: '//*[@class="FAQ"]')

    link(:player_video_helper_center, xpath: '//*[@id="player"]')
    link(:link_article_tip_tricks, xpath: '//*[@id="mainForm"]//div/p[2]/a[contains(@href,"/tipstricks/context-menu.aspx")]')
    link(:pricing_faq, xpath: '//*[contains(@href,"/faq/pricing.aspx")]')
    link(:doc_read_print, xpath: '//*[@id="link_085"]')

    link(:add_comment_help, xpath: '//*[@href="#comments"]')

    elements(:modules_list_getting_started, xpath: '//*[@id="productsMainContent"]//a')

    link(:headers_menu, xpath: '//nav//a[@class="menuitem"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        help_center_site_map_visible?
      end
    end

    def help_center_site_map_visible?
      headers_menu_element.present?
    end

    def click_module_name_getting_started(module_name)
      index = %i[document_editors documents projects crm community calendar mail talk].index(module_name)
      modules_list_getting_started_elements[index].click
      wait_to_load
    end

    def products_documents_visible?
      products_documents_element.present?
    end

    def documents_getting_started_help_visible?
      documents_getting_started_element.present?
    end

    def search_in_helper_center(text_search)
      self.search = "#{text_search}\n"
      @instance.webdriver.wait_until do
        result_search_with_text_search(text_search)
      end
    end

    def result_search_with_text_search(text_search)
      @instance.webdriver.get_text(first_result_search_element).include?(text_search)
    end

    def navigate_of_helper_center(navigate)
      documentation_type_element.click unless getting_started_element.present?
      link = { getting_started: getting_started_element, user_guides: user_guides_element, video_guides: video_guides_element,
               tips_tricks: tips_tricks_element, troubleshooting: troubleshooting_element,
               teamLab_co_authors: teamLab_co_authors_element, glossary: glossary_element, faq: faq_element,
               read_print: read_print_element, getting_started_main_page: getting_started_main_page_element,
               read_more_user_guides: read_more_user_guides_element }
      navigate = :getting_started if navigate == :getting_started_main_page
      navigate = :user_guides if navigate == :read_more_user_guides
      link[navigate].click
      @instance.webdriver.wait_until do
        navigate_helper_center_link_visible?(navigate)
      end
    end

    def navigate_helper_center_link_visible?(navigate)
      wait = hash_link_on_second_page_helper_center
      @instance.webdriver.element_present?(wait[navigate])
    end

    def hash_link_on_second_page_helper_center
      { getting_started: title_documents_getting_started_element, user_guides: article_user_guides_element,
        video_guides: first_title_video_guides_element, tips_tricks: article_tips_tricks_element,
        troubleshooting: documents_troubleshooting_element, teamLab_co_authors: first_videos_teamLab_co_authors_element,
        glossary: first_link_glossary_element, faq: first_link_faq_element, read_print: doc_read_print_element }
    end

    def show_contents_getting_started
      show_documents_getting_started_element.click
      @instance.webdriver.wait_until do
        !show_documents_getting_started_element.present?
      end
      hide_documents_getting_started_visible?
    end

    def hide_documents_getting_started_visible?
      hide_documents_getting_started_element.present?
    end

    def click_on_overview_getting_started_document
      overview_documents_getting_started_element.click
      @instance.webdriver.wait_until do
        add_comment_help_visible?
      end
    end

    def link_on_article_page_video_player_visible?
      @instance.webdriver.select_frame("//*[contains(@class,'bigVideoCont')]/iframe")
      visible = player_video_helper_center_element.present?
      @instance.webdriver.select_top_frame
      visible
    end

    def click_on_link_second_page_helper_center(link_name)
      link = { icon_document_getting_started: icon_documents_getting_started_element, title_document_getting_started: title_documents_getting_started_element,
               read_more_document_getting_started: read_more_documents_getting_started_element, article_user_guides: article_user_guides_element,
               link_article_tip_tricks: link_article_tip_tricks_element, pricing_faq: pricing_faq_element, portal_configuration: portal_configuration_element }
      link = link.merge(hash_link_on_second_page_helper_center)
      link[link_name].click
      @instance.webdriver.wait_until do
        if %i[video_guides teamLab_co_authors].include?(link_name)
          link_on_article_page_video_player_visible?
        elsif %i[glossary pricing_faq].include?(link_name)
          google_plus_visible?
        else
          add_comment_help_visible?
        end
      end
    end

    def add_comment_help_visible?
      add_comment_help_element.present?
    end

    def open_first_document_from_read_and_print
      hash_link_on_second_page_helper_center[:read_print].click
      @instance.init_online_documents
      @instance.doc_instance.management.wait_for_operation_with_round_status_canvas
    end
  end
end
