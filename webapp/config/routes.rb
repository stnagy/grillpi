Rails.application.routes.draw do
  
  # send users to the angular application
  root to: "application#angular"
  
end
