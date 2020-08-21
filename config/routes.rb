Rails.application.routes.draw do
  resources :classrooms
  resources :professors
  resources :students

  root "home#index"
end
