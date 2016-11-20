class Public::WelcomeController < ApplicationController
  layout 'public'
  def index
  end
  def faq
  end
  def settings
    @user = current_user
    if current_user
      @team = current_user.user_team
      @algo = current_user.user_algo
      @hide = current_user.user_hide
    else
      @team = session[:user_team]
      @algo = session[:algo_choice]
      @hide = session[:hide_score_value]
    end
  end
  def contact
  end
  def hide_win_loss_session
    session[:hide_win_loss] = params[:hide_win_loss_session][:record]
    redirect_to(:back)
  end
  # def footer_session
  #   cookies[:footer_value] = params[:footer_session][:footer]
  #   redirect_to(:back)
  # end
  def hide_score_session
    session[:hide_score_value] = params[:hide_score_session][:score]
    if current_user
      hide_array = ['', 'HideR', 'ShowR']
      if hide_array.include?(params[:hide_score_session][:score])
        hide_params = params[:hide_score_session][:score]
        @user =  current_user
        @user.user_hide = user_params_hide[:score]
        @user.save
        if hide_params = params[:hide_score_session][:score] == ''
          redirect_to public_settings_path, :notice => 'No option selected'
        else
          redirect_to public_settings_path, :notice => 'Option saved'
        end
      else
        redirect_to public_settings_path, :notice => 'Something went wrong'
      end
    else
      redirect_to public_settings_path
    end
  end
  def pick_team
    session[:user_team] = params[:pick_team_session][:team]
    if current_user
      team_array = ['', 'CLE', 'TB', 'MIN', 'CIN', 'OAK', 'SD', 'MIA', 'NYG', 'DET', 'NE', 'PIT', 'LA', 'NYJ', 'CAR', 'GB', 'BUF', 'CHI', 'TEN', 'BAL', 'DAL', 'NO', 'SF', 'KC', 'SEA', 'JAX', 'ATL', 'IND', 'PHI', 'HOU', 'ARI', 'DEN', 'WAS']
      if team_array.include?(params[:pick_team_session][:team])
        team_params = params[:pick_team_session][:team]
        @user =  current_user
        @user.user_team = user_params_team[:team]
        @user.save
        if team_params = params[:pick_team_session][:team] == ''
          redirect_to public_settings_path, :notice => 'No team selected'
        else
          redirect_to public_settings_path, :notice => 'Team saved'
        end
      else
        redirect_to public_settings_path, :notice => 'Something went wrong'
      end
    else
      redirect_to public_settings_path
    end
    #redirect_to(:back)
  end

  def algo_type
    session[:algo_choice] = params[:algo_type_session][:algo]
    p 'AA: ' + params[:algo_type_session][:algo]
    if current_user
      algo_array = ['', 'FullAlgo', 'MatchAlgo']
      if algo_array.include?(params[:algo_type_session][:algo])
        algo_params = params[:algo_type_session][:algo]
        @user =  current_user
        @user.user_algo = user_params_algo[:algo]
        @user.save
        if algo_params = params[:algo_type_session][:algo]== ''
          redirect_to public_settings_path, :notice => 'No algorithm selected'
        else
          redirect_to public_settings_path, :notice => 'Algorithm option saved'
        end
      else
        redirect_to public_settings_path, :notice => 'Something went wrong'
      end
    else
      redirect_to public_settings_path
    end
  end

  def reset_session
    session.delete(:hide_score_value)
    session.delete(:value)
    session.delete(:user_team)
    session.delete(:algo_choice)
    redirect_to root_path
  end

  private

  def user_params_team
    team_params = params[:pick_team_session][:team]
    #p params[:pick_team_session][:team]
    if team_params
      params.require(:pick_team_session).permit(:team)
      #params.require(:pick_team_session).permit(team: ['', 'KC'])
    else
      {}
    end
  end

  def user_params_algo
    algo_params = params[:algo_type_session][:algo]
    if algo_params
      params.require(:algo_type_session).permit(:algo)
    else
      {}
    end
  end

  def user_params_hide
    hide_params = params[:hide_score_session][:score]
    if hide_params
      params.require(:hide_score_session).permit(:score)
    else
      {}
    end
  end

end
