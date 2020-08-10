Rails.application.routes.draw do
  get 'classrooms/index'
  get 'classrooms/edit'
  get 'classrooms/new'
  get 'classrooms/show'
  resources :professors
  resources :students
end
