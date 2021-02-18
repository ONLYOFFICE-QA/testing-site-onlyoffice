module TestingSiteOnlyoffice
  module SiteCommercialDownloadHelper
    def get_blocks_by_product(product, installer)
      case product
      when 'Docs_Enterprise'
        installer_docs_enterprise_type_block(installer)
      when 'Docs_Developer'
        installer_docs_developer_type_block(installer)
      when 'Workspace'
        installer_type_block(installer)
      end
    end

    def pricing_page_by_product(product)
      case product
      when 'Docs_Enterprise'
        SitePriceDocsEnterprise
      when 'Docs_Developer'
        SitePriceDocsDeveloper
      when 'Workspace'
        SitePriceServerEnterprise
      end
    end
  end
end
