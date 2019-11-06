Rails.application.routes.draw do
  root "users#index"
  devise_for :users

  resource "users", only: [:show]

  get '/u/:id', to: 'users#show_profile', as: "show_profile"

  resources "users",only: [:index, :update], path: "mypage", as: "mypage" do
    collection do
      get 'review'
      resource "lists", only: :show, path: "/l:lists_id",as: "lists_all"
    end
  end

  resources "reviews", only: [:destroy]
  
  resources "books", only: [:index, :new, :create, :edit, :update]
  
  resource "books", path: "/b:book_id", only: :show, as: :show_books do
    resources "reviews", only: [:new, :create, :edit, :update]
    resources "lists", only: [:create]
    resource "lists", only: [:update], as: "list_update"
    resource "lists", only: [:destroy], as: "list_delete"
  end
end
