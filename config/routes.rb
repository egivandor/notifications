Notifications::Engine.routes.draw do
  scope ':messagetype' do
    resources :messages
    get 'messages_count' => 'messages#count', as: 'messages_count'
  end
end
