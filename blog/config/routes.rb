Rails.application.routes.draw do
  get 'numeros_pares/:numero' => 'welcome#pares'

  resources :articles do
    get 'comments'
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
