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

  end

  # scope :week do
  #   resources :week_number, only: [:index, :show] do
  #   end
  #   #get ':week_number' => 'public/weeks'
  #   # get '', to: 'public/weeks#one'
  #   # get '1', to: 'public/weeks#one'
  #   # get '2', to: 'public/weeks#two'
  #   # get '3', to: 'public/weeks#three'
  #   # get '4', to: 'public/weeks#four'
  #   # get '5', to: 'public/weeks#five'
  #   # get '6', to: 'public/weeks#six'
  #   # get '7', to: 'public/weeks#seven'
  #   # get '8', to: 'public/weeks#eight'
  #   # get '9', to: 'public/weeks#nine'
  #   # get '10', to: 'public/weeks#ten'
  # end
end
