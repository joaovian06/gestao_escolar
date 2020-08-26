Rails.application.routes.draw do
  resources :enrollments
  resources :classrooms
  resources :professors
  resources :students

  root "home#index"
end
