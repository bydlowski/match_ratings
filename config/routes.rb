Rails.application.routes.draw do
  devise_for :admin
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
      end
    end
  end

  namespace :public, path: '' do
    resources :weeks, only: [:show], path: 'week', param: :number do
      #get '', to: 'public/welcome#index'
    end
    post 'show_stats', to: 'welcome#save_session'
    post 'hide_footer', to: 'welcome#footer_session'
    post 'hide_ratings', to: 'welcome#hide_score_session'
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
