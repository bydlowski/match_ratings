class Public::WelcomeController < ApplicationController
  layout 'public'
  def index
  end
  def faq
  end
  def settings
    @user = current_user
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
    if current_user
      team_array = ['', 'CLE', 'TB', 'MIN', 'CIN', 'OAK', 'SD', 'MIA', 'NYG', 'DET', 'NE', 'PIT', 'LA', 'NYJ', 'CAR', 'GB', 'BUF', 'CHI', 'TEN', 'BAL', 'DAL', 'NO', 'SF', 'KC', 'SEA', 'JAX', 'ATL', 'IND', 'PHI', 'HOU', 'ARI', 'DEN', 'WAS']
      if team_array.include?(params[:pick_team_session][:team])
        team_params = params[:pick_team_session][:team]

      #FUNC
      #current_user.update_attributes(team: params[:pick_team_session][:team])
      #current_user.save

      #current_user.team = params[:pick_team_session][:team]
      #current_user.save
      #p user_params_team[:team]
      #@user.update(team: user_params_team[:team])

        @user =  current_user
        @user.user_team = user_params_team[:team]
      end
      # @user.save

      #@user.save
      # #p user_params_team.to_a
      if @user.save
        #current_user.update_attributes(team: params[:pick_team_session][:team])
        #current_user.save
        p "yes"
        redirect_to(:back)
      else
        p "noo"
        redirect_to(:back)
      end
    else

    end
    #redirect_to(:back)
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

end
