Rails.application.routes.draw do
  root 'public/welcome#index', to: 'public/welcome#index'

  scope :tests do
    get '', to: 'public/tests#index'
    get 'stats', to: 'public/tests#stats'
    get 'games', to: 'public/tests#games'
    get 'full', to: 'public/tests#full'
    get 'table', to: 'public/tests#table'
  end

  namespace :public, path: '' do
    resources :weeks, only: [:show], path: 'week', param: :number do
      #get '', to: 'public/welcome#index'
    end
    post 'show_stats', to: 'welcome#save_session'
    post 'hide_footer', to: 'welcome#footer_session'
    get 'week', to: 'welcome#index'
    get 'faq', to: 'welcome#faq'
    get 'settings', to: 'welcome#settings'
    get 'contact', to: 'welcome#contact'
  end
end
