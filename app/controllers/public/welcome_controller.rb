class Public::WelcomeController < ApplicationController
  layout 'public'
  def index
  end
  def save_session
    session[:value] = params[:save_session][:choice]
    redirect_to(:back)
  end
end
