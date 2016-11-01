Rails.application.routes.draw do
  root 'public/welcome#index', to: 'public/welcome#index'

  scope :tests do
    get '', to: 'public/tests#index'
    get 'stats', to: 'public/tests#stats'
    get 'games', to: 'public/tests#games'
    get 'full', to: 'public/tests#full'
    get 'table', to: 'public/tests#table'
  end

  scope :week do
    get '', to: 'public/weeks#one'
    get '1', to: 'public/weeks#one'
    get '2', to: 'public/weeks#two'
    get '3', to: 'public/weeks#three'
    get '4', to: 'public/weeks#four'
    get '5', to: 'public/weeks#five'
    get '6', to: 'public/weeks#six'
    get '7', to: 'public/weeks#seven'
    get '8', to: 'public/weeks#eight'
    get '9', to: 'public/weeks#nine'
    get '10', to: 'public/weeks#ten'
  end
end
