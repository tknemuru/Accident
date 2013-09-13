Accident::Application.routes.draw do
  root to: "top#index"
  get "about" => "top#about", as: "about"
  get "execute" => "top#execute",  as: "execute"
end
