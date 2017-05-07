Rails.application.routes.draw do
  devise_for :users, :path => 'users', :controllers => {sessions: 'users/sessions',
                                                        passwords: 'passwords',
                                                        registrations: 'users/registrations',
                                                        unlocks: 'unlocks'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :measures

  get 'instructions' => 'static#instructions'
  get 'recommendations' => 'static#recommendations'

  root 'static#index'


end
