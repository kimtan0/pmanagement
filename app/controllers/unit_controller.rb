class UnitController < ApplicationController

  before_action :check_unit, only: [:dashboard]

  def dashboard
    @unit = Unit.find(cookies[:unit_id])
    @amount = (@unit.rental_amount / 100).to_s + "$"
    @due =  (@unit.due_amount / 100).to_s + "$"
  end

  def authentication
    unit = Unit.find_by(username: params[:username])
    if unit.present? && unit.authenticate(params[:password])
      cookies[:unit_id] = unit.id
      redirect_to unit_dashboard_path
    else
      redirect_to unit_login_path, notice: "Incorrect Credentials"
    end
  end

  def payment
    @unit = Unit.find(cookies[:unit_id])
    @due =  (@unit.payment.due / 100).to_s + "$"
  end

  def payment_process
  end

  def complaint
    unit = Unit.find(cookies[:unit_id])
    @complaint = Complaint.new
  end

  def complaint_process
    unit = Unit.find(cookies[:unit_id])
    Complaint.create(complaint_params.merge(unit_id: unit.id))
    redirect_to unit_dashboard_path
  end

  private

  def check_unit
    if !cookies[:unit_id].present?
      redirect_to unit_login_path
    end
  end

  def complaint_params
    params.require(:complaint).permit(:description, :complaint_image)
  end

end