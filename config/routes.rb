Rails.application.routes.draw do

  get 'unit/dashboard', to: 'unit#dashboard'
  get 'unit/login', to: "unit#login"
  post 'unit/login', to: "unit#authentication", as: :authentication
  get 'unit/payment', to: "unit#payment"
  post 'unit/payment', to: "unit#payment_process", as: :payment_process
  get 'unit/maintainance', to: "unit#maintainance"
  post 'unit/maintainance', to: "unit#maintainance_process", as: :maintainance_process

  # Admin pages
  get 'admin/dashboard', to: 'admin#dashboard'
  get 'admin/units', to: 'admin#unit_list'
  get 'admin/units/new', to: 'admin#new'
  post 'admin/units/new', to: 'admin#create'
  get 'admin/units/:id', to: 'admin#view', as: 'view_unit'
  get 'admin/units/:id/edit', to: 'admin#edit', as: 'edit_unit'
  patch 'admin/units/:id/edit', to: 'admin#update'
  delete 'admin/units/:id', to: 'admin#destroy', as: 'delete_unit'
  get 'admin/overdue', to: 'admin#overdue'
end
