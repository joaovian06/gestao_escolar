Rails.application.routes.draw do
  get 'home/index'
  resources :classrooms
  resources :professors
  resources :students

  root "home#index"
end
