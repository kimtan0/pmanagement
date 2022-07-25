class AdminController < ApplicationController
  before_action :check_unit

  def dashboard
  end

  def unit_list
    @units = Unit.all.order(unit_number: :desc)
  end

  def new
    @unit = Unit.new
  end 

  def create
    unit = Unit.create(unit_params.merge(user_type: 'client', due_amount: 0, password_digest: BCrypt::Password.create(params[:unit][:password_digest])))

    redirect_to admin_dashboard_path
  end 

  def view 
    @unit = Unit.find(params[:id].to_i)
    @payments = @unit.payment
  end 

  def edit
    @unit = Unit.find(params[:id].to_i)
  end 

  def update
    unit = Unit.find(params[:id].to_i)

    if params[:unit][:password_digest].empty?
      unit.update!(unit_params.merge(password_digest: unit.password_digest))
    else
      unit.update!(unit_params.merge(password_digest: BCrypt::Password.create(params[:unit][:password_digest])))
    end
    
    redirect_to admin_dashboard_path
  end

  def destroy
    unit = Unit.find(params[:id].to_i)

    unit.payment.destroy_all
    unit.destroy

    redirect_to admin_units_path
  end 

  def overdue
    @units = Unit.where('due_amount > ?', 0)
  end

  def print_list
    @units = Unit.all.order(unit_number: :desc)
  end

  def print_unit
    @unit = Unit.find(params[:id].to_i)
    @payments = @unit.payment
  end

  def print_overdue
    @units = Unit.where('due_amount > ?', 0)
  end

  def logout
    cookies.delete :unit_id
    
    redirect_to unit_login_path
  end

  private

  def unit_params
    params.require(:unit).permit(:unit_number, :unit_address, :unit_type, :storey, :tenure, :floor_size, :land_size, :washroom, :bedroom, :username, :password_digest, :tenant_name, :tenant_phone_number, :tenant_email, :rental_amount)
  end

  def check_unit
    if !cookies[:unit_id].present?
      redirect_to unit_login_path
    end
  end
end