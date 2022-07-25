Rails.application.routes.draw do

  get 'unit/dashboard', to: 'unit#dashboard'
  get 'unit/login', to: "unit#login"
  post 'unit/login', to: "unit#authentication", as: :authentication
  get 'unit/payment', to: "unit#payment"
  post 'unit/payment', to: "unit#payment_process", as: :payment_process
  get 'unit/maintainance', to: "unit#maintainance"
  post 'unit/maintainance', to: "unit#maintainance_process", as: :maintainance_process

end
