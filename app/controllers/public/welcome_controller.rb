class Public::WelcomeController < ApplicationController
  layout 'public'
  def index
  end
  def faq
  end
  def settings
  end
  def contact
  end
  def save_session
    session[:value] = params[:save_session][:choice]
    redirect_to(:back)
  end
  def footer_session
    p params
    session[:footer_value] = params[:footer_session][:footer]
    redirect_to(:back)
  end
end
