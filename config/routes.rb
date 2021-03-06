EasyLearning::Application.routes.draw do

  mount RailsAdmin::Engine => 'administration', :as => 'rails_admin'
  get "surveys/index"
  get "home/index"


  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }
 
  root "home#index"

  resources :home do
    collection do
      get 'contact'
      get 'about'
      get 'services'
      get 'portfolio'
    end
  end
  resources :subjects do
    resources :surveys do
      get 'run' => 'survey_run#run'
      post 'calc_result' => 'survey_run#calc_result'
      get 'results' => 'survey_run#view_results'
    end
  end
  get '/survey/edit/getSurvey' => 'surveys#getSurvey'
  post '/survey/edit/question/add' => 'surveys#addQuestion'
  post '/survey/edit/question/delete' => 'surveys#deleteQuestion'
  post '/survey/edit/answer/add' => 'surveys#addAnswer'
  post '/survey/edit/answer/delete' => 'surveys#deleteAnswer'
  post '/survey/edit/answer/triggerIsRight' => 'surveys#triggerAnswer'


  resources :events
  resources :files, :only => [:index, :show]  do
    collection do
      get "omniauth_callback"
      post "upload"
    end
  end
   
  namespace :user do
    resources :home
    resource :settings, :only => [:show, :update]
    resource :schedule, :only => [:show]
    # resources :files, :only => [:index, :show] do
    #   collection do
    #     get "omniauth_callback"
    #     post "upload"
    #   end
    # end
  end
  
  namespace :user, path: "", only: [] do
    namespace :admin do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
      resources :files, :only => [:index, :show] do
        collection do
          get "omniauth_callback"
          post "upload"
        end
      end
      
    end

    namespace :lecturer do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
      resources :files, :only => [:index, :show] do
        collection do
          get "omniauth_callback"
          post "upload"
        end
      end

    end

    namespace :student do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
      resources :files, :only => [:index, :show] do
        collection do
          get "omniauth_callback"
          post "upload"
        end
      end

    end
  end


  


  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
