class ApplicationController < ActionController::Base
  # before_action :set_locale
  around_action :switch_locale

  include SessionsHelper
  def hello
    render html: "hello, world!"
  end

  private #protected
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # def set_locale
    #   I18n.locale = params[:locale] || I18n.default_locale
    # end

    # locale for next url
    def default_url_options
      {locale: I18n.locale}
    end

    def switch_locale(&action)
      locale = available_locale
      I18n.with_locale(locale, &action)
    end

    def available_locale
      if params[:locale]
        I18n.available_locales.include?(params[:locale].to_sym)? params[:locale] : I18n.default_locale
      end
    end
end
