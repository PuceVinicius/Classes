Rails.application.routes.draw do
  get 'manda/index'
  resources :atividades
  root 'manda#index'
  get 'index' => 'avisos#index'
  post 'atividades/new', to: 'atividades#new'
  resources :avisos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
