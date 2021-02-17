# Methods for signin page

module TestingSiteOnlyoffice
  module SignInMethods
    # Open SigIn Page
    # @param open_signin_by_url [True, False]
    #   true - open page by opening direct link,
    #   false - open page by entering top menu of Site
    def sign_in_from_sign_in(site_data, name_network = :teamlab, open_signin_by_url: true)
      sign_in = if open_signin_by_url
                  open_sign_in_by_url
                else
                  click_link_on_toolbar(:sign_in)
                end
      sign_in.sign_in_to_teamlab_site(site_data, name_network)
      sign_in
    end

    # Open SigIn page directly by url
    def open_sign_in_by_url
      current_url = URI(@instance.webdriver.get_url)
      open_uri = "#{current_url.scheme}://#{current_url.host}/signin.aspx?#{current_url.query}"
      @instance.webdriver.open(open_uri)
      SiteSignIn.new(@instance)
    end
  end
end
