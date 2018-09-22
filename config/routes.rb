Rails.application.routes.draw do
  root "campaigns#index"
  
  resources :campaigns do

    resources :links do
      collection {post :import}
      collection {post :take_screenshot}
      collection {get :create_zip}

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
