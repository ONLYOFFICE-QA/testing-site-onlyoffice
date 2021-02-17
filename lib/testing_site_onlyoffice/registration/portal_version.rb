module TestingSiteOnlyoffice
  module PortalVersion
    def get_portal_name(test_name = '')
      test_name.gsub!('http:', 'https:') if StaticDataTeamLab.portal_type == '.com'
      if StaticDataTeamLab.version_from_info_on_com && StaticDataTeamLab.portal_type == '.com' && !test_name.include?('html5')
        test_name.gsub!(".#{StaticDataTeamLab.get_domain}",
                        "-next-version.#{StaticDataTeamLab.get_domain}")
      end

      test_name + if StaticDataTeamLab.portal_type == '.com'
                    case StaticDataTeamLab.server_region
                    when 'eu'
                      '.eu'
                    when 'sg'
                      '.sg'
                    when 'org'
                      '.org'
                    else
                      StaticDataTeamLab.portal_type
                    end
                  else
                    case StaticDataTeamLab.server_region
                    when 'eu'
                      '.io'
                    else
                      StaticDataTeamLab.portal_type
                    end
                  end
    end

    def get_portal_name_in_region(portal, add_suffics = false, region = StaticDataTeamLab.server_region)
      suffics = ''
      raise "Unknwon region for portal name: #{region}" unless StaticDataTeamLab.portal_type == '.com'

      if region == 'us'
        "https://#{portal}.#{StaticDataTeamLab.get_domain}.com"
      elsif region == 'eu'
        suffics = '-eu' if add_suffics
        "https://#{portal}#{suffics}.#{StaticDataTeamLab.get_domain}.eu"
      elsif region == 'sg'
        suffics = '-sg' if add_suffics
        "https://#{portal}#{suffics}.#{StaticDataTeamLab.get_domain}.sg"
      elsif StaticDataTeamLab.server_region == 'org'
        suffics = '-org' if add_suffics
        "https://#{portal}#{suffics}.#{StaticDataTeamLab.get_domain}.org"
      end
    end

    def get_full_portal_name(portal_to_create, portal_type = StaticDataTeamLab.portal_type)
      protocol = if portal_type == '.info' && StaticDataTeamLab.server_region == 'eu'
                   'http://'
                 else
                   'https://'
                 end
      if portal_to_create == 'www'
        portal_type = '.com' if StaticDataTeamLab.server_region == 'eu' || StaticDataTeamLab.server_region == 'sg'
        portal_type = '.org' if StaticDataTeamLab.server_region == 'org'
      end
      portal_zone = get_current_part_for_main_portal(portal_to_create, portal_type)
      portal_domain = StaticDataTeamLab.get_domain
      portal_domain = 'onlyoffice' if portal_domain == 'teamlab' && portal_zone == '.com'
      protocol + portal_to_create + ".#{portal_domain}" + portal_zone
    end

    def get_current_part_for_main_portal(current_portal_name, current_part)
      if current_portal_name != 'www'
        current_part = if StaticDataTeamLab.portal_type == '.com'
                         case StaticDataTeamLab.server_region
                         when 'eu'
                           '.eu'
                         when 'sg'
                           '.sg'
                         when 'org'
                           '.org'
                         else
                           StaticDataTeamLab.portal_type
                         end
                       else
                         case StaticDataTeamLab.server_region
                         when 'eu'
                           '.io'
                         else
                           StaticDataTeamLab.portal_type
                         end
                       end
      end
      current_part
    end

    def get_short_portal_name(portal_name)
      portal_name.split('://').last.split(".#{StaticDataTeamLab.get_domain}").first
    end

    class << self
      def without_editors?
        install? && !StaticDataTeamLab.version.include?('DS')
      end

      def no_3rd_party_keys?
        StaticDataTeamLab.version.include?('no3rd')
      end

      def install?
        community? || enterprise? || hosted?
      end

      # ES == CS + DS + CP
      def enterprise?
        StaticDataTeamLab.version.include?('ES')
      end

      def community?
        StaticDataTeamLab.version.include?('CS')
      end

      def hosted?
        StaticDataTeamLab.version.include?('hosted')
      end

      def install_linux?
        install? && !StaticDataTeamLab.version.include?('win')
      end

      def mail_server?
        StaticDataTeamLab.version.include?('MS') || !install?
      end
    end
  end
end
