Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/keyboard' => 'basic#keyboard_init'
  post '/message' => 'basic#chat_control'
  post '/friend' => 'basic#new_friend'
  post '/friend/:user_key' => 'basic#new_friend'
  delete '/friend/:user_key' => 'basic#deleted_friend'
  delete '/chat_room/:user_key' => 'basic#left_chat'
end
