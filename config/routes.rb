Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events

  resources :rooms

  get 'week' => 'calendar#week', as: :week

  get 'day' => 'calendar#day', as: :day

  root 'calendar#index'
end
