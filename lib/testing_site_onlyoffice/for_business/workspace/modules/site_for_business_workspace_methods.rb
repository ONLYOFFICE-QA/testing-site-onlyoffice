# frozen_string_literal: true

module TestingSiteOnlyoffice
  # methods for features workspace group
  module SiteForBusinessWorkspaceMethods

    def xpath_section(section)
      "//div[contains(@class, 'cms_block oses_#{section} menuitem')]"
    end

    def check_select?(section)
      attribute = @instance.webdriver.get_attribute(xpath_section(section), 'class')
      return true if attribute.include?('selected')

      @instance.webdriver.webdriver_error('Unselected section')
    end

    def select_section
      {
        documents: {
          xpath: '//ul[contains(@class, "pict-dots")]/li[1]',
          class: SiteWorkspaceDocumentManager,
          page: '/document-management.aspx'
        },
        mail: {
          xpath: '//ul[contains(@class, "pict-dots")]/li[2]',
          class: SiteWorkspaceMail,
          page: '/mail.aspx'
        },
        crm: {
          xpath: '//ul[contains(@class, "pict-dots")]/li[3]',
          class: SiteWorkspaceCRM,
          page: '/crm.aspx'
        },
        projects: {
          xpath: '//ul[contains(@class, "pict-dots")]/li[4]',
          class: SiteWorkspaceProjects,
          page: '/projects.aspx'
        },
        calendar: {
          xpath: '//ul[contains(@class, "pict-dots")]/li[5]',
          class: SiteWorkspaceCalendar,
          page: '/calendar.aspx'
        }
      }
    end

    def click_on_section_link(section)
      xpath = select_section[section][:xpath]
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      link = "//a[contains(@href, '#{select_section[section][:page]}')]"
      @instance.webdriver.click_on_locator(link)
      select_section[section][:class].new(@instance)
    end
  end
end
