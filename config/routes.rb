Notifications::Engine.routes.draw do
  scope ':messagetype' do
    get 'messages' => 'messages#index', as: 'messages'
    # get 'messages/:id' => 'messages#show', as: 'notification'
    get 'messages_count' => 'messages#count', as: 'messages_count'
  end
end
