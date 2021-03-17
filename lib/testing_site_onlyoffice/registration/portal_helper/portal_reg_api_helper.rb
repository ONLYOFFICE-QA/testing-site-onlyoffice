# work in progress: can not change portals version
module PortalRegAPIHelper
  AVAILIABLE_LANGUAGES = {
    'en-US' => 'us',
    'ru-RU' => 'ru',
    'de-DE' => 'de',
    'fr-FR' => 'fr',
    'it-IT' => 'it',
    'es-ES' => 'es',
    'pt-BR' => 'pt',
    'cs-CZ' => 'cs'
  }.freeze

  DEFAULT_TIMEZONE = 'Europe/Moscow'.freeze
  DEFAULT_PHONE = '0000000000'.freeze

  def reg_portal_via_api(data, _change_language_flag = StaticDataTeamLab.change_portal_language_flag, language = StaticDataTeamLab.current_language, _site_language = 'en-US')
    OnlyofficeLoggerHelper.log("Going to create portal via api: #{data.portal_to_create}")
    portal = reg_via_apisystem_request(data, language)
    owner_data = data.custom_user_list.find { |user| user.type == :admin }
    api = GeneralApiService.new(portal, owner_data.mail, owner_data.pwd)
    user_list = data.custom_user_list
    user_list.each { |user| user.portal = portal }
    api.people.restore_custom_user_list user_list
    user_list.unshift(owner_data)
    user_list.each do |user|
      GeneralApiService.new(portal, user.mail, user.pwd)
      Teamlab.settings.update_tips false
    end
    GeneralApiService.new(portal, owner_data.mail, owner_data.pwd)
    user_list
  end

  def reg_via_apisystem_request(data, language)
    path = "https://api-system.#{StaticDataTeamLab.get_domain}#{StaticDataTeamLab.portal_type}/api/portal/register"
    owner_data = data.custom_user_list.detect { |user| user.type == :admin }
    body = {
      'firstName' => owner_data.first_name,
      'lastName' => owner_data.last_name,
      'email' => owner_data.email,
      'phone' => DEFAULT_PHONE,
      'portalName' => data.portal_to_create,
      'timeZoneName' => DEFAULT_TIMEZONE,
      'language' => AVAILIABLE_LANGUAGES[language],
      'password' => owner_data.pwd
    }
    result = HTTParty.post(path, body: body)
    raise("api portal reg: something went wrong with error: #{result}") unless result.success?

    OnlyofficeLoggerHelper.log("reg result: #{result}")
    portal = URI.parse(JSON.parse(result.response.body)['reference'])
    "#{portal.scheme}://#{portal.host}"
  end
end
