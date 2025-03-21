# frozen_string_literal: true

require_relative '../data/site_data'

module OnlyofficeIredmailHelper
  # Module with methods to work with email body
  module MailHelper
    # Check whether full name from parameters is equal to the name from an email.
    # Find an index of the word that comes before the name and take the next word as name.
    # E.g. 'Full', 'name', 'Andrew', 'Johnson' -> 'name' is the key word here so the next word is the actual name -> 'Andrew'
    # @return [Boolean] True if matches, False if not
    def full_name_match?
      full_name = @params.fetch(:full_name, TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME)
      full_name == "#{@body[@body.find_index('name') + 1]} #{@body[@body.find_index('name') + 2]}"
    end

    def email_match?
      email = @params.fetch(:email, TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN)
      email == @body[@body.find_index('Email') + 1]
    end

    def phone_number_match?
      phone_number = @params[:phone_number]
      phone_number == @body[@body.find_index('Phone') + 1]
    end

    def company_name_match?
      company_name = @params[:company_name]
      company_name == @body[(@body.find_index('Name') + 1)..(@body.find_index('Language') - 1)].join(' ')
    end

    def support_level_match?
      support_level = @params[:level]
      support_level == @body[@body.find_index('level') + 1]
    end

    def users_number_match?
      users_number = @params[:users_number]
      users_number == @body[@body.find_index('Number') + 3]
    end

    # Method that checks the commonly shared inputs between different emails
    # @return [Boolean] True if all 4 methods return true, False if at least 1 method returns false
    def basic_email_content_check
      full_name_match? &&
        email_match? &&
        company_name_match? &&
        support_level_match? &&
        users_number_match?
    end

    def contact_information_check
      full_name_match? &&
        email_match? &&
        company_name_match?
    end

    def all_additional_tools_check
      access_to_api? &&
        live_viewer? &&
        mobile_apps? &&
        desktop_apps? &&
        training_courses?
    end

    def multi_server_deployment?
      status = @params[:support_multi]
      support = @body[@body.find_index('deployment') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def access_to_api?
      status = @params[:access_to_api]
      support = @body[@body.find_index('API') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def live_viewer?
      status = @params[:live_viewer]
      support = @body[@body.find_index('viewer') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def mobile_apps?
      status = @params[:mobile_apps]
      support = @body[@body.find_index('mobile') + 2]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def desktop_apps?
      status = @params[:desktop_apps]
      support = @body[@body.find_index('Desktop') + 2]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def training_courses?
      status = @params[:training_course]
      support = @body[@body.find_index('courses') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def recovery_support?
      status = @params[:support_recovery]
      support = @body[@body.find_index('recovery') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def license_activated?
      duration = @params[:duration]
      license = @body[@body.find_index('duration') + 1]
      support = @body[@body.find_index('Support&Updates') + 1]
      if duration == 'one_year'
        (license == '1') && (support == '1')
      elsif duration == 'lifetime'
        (license == 'Lifetime') && (support == '3')
      end
    end

    def cloud_type_match?
      type = @params[:type]
      type == @body[@body.find_index('type') + 1]
    end

    def multi_tenancy_support?
      status = @params[:support_multi_tenancy]
      support = @body[@body.find_index('multi-tenancy') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def development_license?
      status = @params[:licence_development]
      license = @body[@body.find_index('Development') + 1]
      license == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def production_license?
      status = @params[:licence_production]
      license = @body[@body.find_index('Production') + 1]
      license == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def non_production_license?
      status = @params[:licence_non_production]
      license = @body[@body.find_index('Non-production') + 1]
      license == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def all_licensing_conditions_check
      development_license? && production_license? && non_production_license?
    end

    def branding_type_match?
      branding_type = @params[:branding_type]
      branding_type == @body[@body.find_index('Branding') + 1]
    end

    def switched_to_the_cloud_match?
      cloud_version = @params[:cloud_version]
      cloud_version == (@body[@body.find_index('cloud') + 1] == 'version')
    end

    def technical_problems_match?
      technical_problems = @params[:technical_problems]
      actual_technical_problems = @body.include?('technical') && @body.include?('problems')

      technical_problems == actual_technical_problems
    end

    def necessary_features_match?
      necessary_features = @params[:necessary_features]
      actual_necessary_features = @body.include?('necessary') && @body.include?('features')

      necessary_features == actual_necessary_features
    end

    def legal_violation_match?
      legal_violation = @params[:legal_violation]
      actual_legal_violation = @body.include?('violation')

      legal_violation == actual_legal_violation
    end

    def rarely_use_match?
      rarely_use = @params[:rarely_use]
      actual_rarely_use = @body.include?('rarely') && @body.include?('use')

      rarely_use == actual_rarely_use
    end

    def storage_space_match?
      storage_space = @params[:storage_space]
      actual_storage_space = @body.include?('storage') && @body.include?('space')

      storage_space == actual_storage_space
    end

    def rarely_work_match?
      rarely_work = @params[:rarely_work]
      actual_rarely_work = @body.include?('rarely') && @body.include?('work')

      rarely_work == actual_rarely_work
    end

    def another_desktop_software_match?
      another_software = @params[:another_desktop_software]
      actual_another_software = @body.include?('another') && @body.include?('desktop')

      another_software == actual_another_software
    end

    def switched_on_premises_match?
      switched_on_premises = @params[:switched_on_premises]
      actual_switched_on_premises = @body.include?('Switched') && @body.include?('on-premises')

      switched_on_premises == actual_switched_on_premises
    end

    def switched_to_personal_match?
      switched_to_personal = @params[:switched_to_personal]
      actual_switched_to_personal = @body.include?('Switched') && @body.include?('Personal')

      switched_to_personal == actual_switched_to_personal
    end
  end
end
