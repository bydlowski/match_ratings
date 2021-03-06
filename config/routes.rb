Rails.application.routes.draw do
  devise_for :admin
  #devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }
  root 'public/welcome#index', to: 'public/welcome#index'

  namespace :admin do
    authenticated :admin do
      root 'welcome#index'
      scope :tests do
        get '', to: 'tests#index'
        get 'stats', to: 'tests#stats'
        get 'games', to: 'tests#games'
        get 'full', to: 'tests#full'
        get 'table', to: 'tests#table'
        get 'allparams', to: 'tests#allparams'
        get 'lead', to: 'tests#lead'
      end
      get 'logs', to: 'logs#index'
    end
  end

  namespace :public, path: '' do
    resources :weeks, only: [:show], path: 'week', param: :number do
      #get '', to: 'public/welcome#index'
    end
    post 'show_stats', to: 'welcome#hide_win_loss_session'
    post 'hide_footer', to: 'welcome#footer_session'
    post 'hide_ratings', to: 'welcome#hide_score_session'
    post 'algorithm_choice', to: 'welcome#algo_type'
    get 'reset_session', to: 'welcome#reset_session'
    post 'pick_team', to: 'welcome#pick_team'
    get 'week', to: 'welcome#index'
    get 'faq', to: 'welcome#faq'
    get 'settings', to: 'welcome#settings'
    get 'contact', to: 'welcome#contact'
  end

  devise_scope :admin do
    get '/admin/sign_out' => 'devise/sessions#destroy'
  end

end
