LadyN::Application.routes.draw do

  
  scope "/:locale", :locale => /en|ru|de/ do
    
    devise_for :admins

    get "admins" => redirect("/%{locale}/admins/sign_in")

    get  'front_page/edit' => "frontPage#edit"
    post 'front_page/update' => "frontPage#update"    
    
    get "contacts" => "contacts#show", :as => :contacts
    get "contacts/edit" => "contacts#edit", :as => :edit_contacts
    post "contacts/update" => "contacts#update", :as => :update_contacts

    get "about" => "about#show", :as => :about
    get "about/edit" => "about#edit", :as => :edit_about
    post "about/update" => "about#update", :as => :update_about
    
    resources :slides
    resources :users

    resources :collections do
      collection do      
        get 'our-clients' => "collections#our_clients", :as => :our_clients
      end
    
      resources :images do
        resources :comments
      end
    end
  
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  match "/:locale" => "frontPage#show", :locale => /en|ru|de/, :as => :root
  
  match "/" => redirect("/ru")

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
