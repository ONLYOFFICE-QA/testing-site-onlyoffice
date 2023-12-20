module OnlyofficeIredmailHelper
  # Additional method to work with IredMailHelper class
  class IredMailHelper
    def check_partners_mail_by_body(params = {})
      body = get_text_body_email_by_subject(params)
      number = body.scan(/[+][0-9]*\s?[0-9]+\s?[0-9]{4,10}/).join
      body.sub!(number, number.delete(' '))
      user_data = []
      user_data.push(params.fetch(:full_name, TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME))
      user_data.push(params.fetch(:email, TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN))
      user_data.push(Regexp.escape(params[:phone_number]))
      user_data.push(params[:company_name])
      params[:support_multi] ? user_data.push('multi-server deployment Selected') : user_data.push('multi-server deployment Not selected')
      params[:training_course] ? user_data.push('courses Selected') : user_data.push('courses Not selected')
      user_data.map! { |check_item| "(?=.*#{check_item})" }
      re_exp = ''
      user_data.each { |element| re_exp.concat(element) }
      re_exp.concat('.*')
      body.match?(Regexp.new(re_exp))
    end
  end
end
