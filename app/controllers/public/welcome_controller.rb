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
  # def footer_session
  #   cookies[:footer_value] = params[:footer_session][:footer]
  #   redirect_to(:back)
  # end
  def hide_score_session
    session[:hide_score_value] = params[:hide_score_session][:score]
    redirect_to(:back)
  end
  def pick_team
    session[:user_team] = params[:pick_team_session][:team]
    redirect_to(:back)
  end
  def algo_type
    session[:algo_choice] = params[:algo_type_session][:algo]
    redirect_to(:back)
  end
  def reset_session
    session.delete(:hide_score_value)
    session.delete(:value)
    session.delete(:user_team)
    session.delete(:algo_choice)
    redirect_to root_path
  end
end
