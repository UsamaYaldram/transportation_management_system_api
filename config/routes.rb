Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :drivers, only: [:create] do
    collection do
      post :login
    end
  end

  resources :trucks, only: [:index] do
    collection do
      post :assign
      get :assigned
    end
  end
end
