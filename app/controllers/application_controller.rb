class ApplicationController < ActionController::Base
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  private

  def set_locale
    I18n.locale = current_user&.language&.code || lang_from_params
  end

  def lang_from_params
    return 'en' if params[:lang].blank?

    available_languages = Language.all.pluck(:code)
    available_languages.include?(params[:lang]) ? params[:lang].to_s : 'en'
  end
end
