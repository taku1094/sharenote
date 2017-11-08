Rails.application.routes.draw do
  devise_for :users
  root 'notes#index'
    get '/home' => 'home#top'
    resources :notes
    resources :timetables do
        resources :lectures do
            resources :notes,only: [:index,:show]
        end
    end
    post '/timetables/:timetable_id/lectures/:lecture_id/notes/:note_id' => 'notes#add'
    delete '/timetables/:timetable_id/lectures/:lecture_id/notes/:note_id' => 'notes#delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
