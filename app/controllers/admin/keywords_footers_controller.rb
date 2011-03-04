class Admin::KeywordsFootersController < Admin::BaseController
  def show
  end

  def update
    keywords_footer_prefs = params[:preferences]
    Spree::Config.set(:keywords_footer => params[:preferences][:keywords_footer] ) if params[:preferences][:keywords_footer].present?

    respond_to do |format|
      format.html {
        redirect_to admin_keywords_footer_path
      }
    end
  end
end
