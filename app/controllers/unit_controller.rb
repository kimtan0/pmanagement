class UnitController < ApplicationController
  before_action :check_unit, only: [:dashboard]
  before_action :already_logged_in, only: [:login, :authentication]

  def dashboard
    @unit = Unit.find(cookies[:unit_id])
    @amount = (@unit.rental_amount / 100).to_s + "$"
    @due =  (@unit.due_amount / 100).to_s + "$"
  end

  def login
  end

  def authentication
    unit = Unit.find_by(username: params[:username])
    if unit.present? && unit.authenticate(params[:password])
      cookies[:unit_id] = unit.id
      if unit.user_type == 'client'
        redirect_to unit_dashboard_path
      else
        redirect_to admin_dashboard_path
      end
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

  def maintainance
    unit = Unit.find(cookies[:unit_id])
    @complaint = Complaint.new
  end

  def maintainance_process
  end

  private

  def check_unit
    if !cookies[:unit_id].present?
      redirect_to unit_login_path
    end
  end

  def already_logged_in
    if cookies[:unit_id].present?
      unit = Unit.find(cookies[:unit_id])

      if unit.user_type == 'client'
        redirect_to unit_dashboard_path
      else
        redirect_to admin_dashboard_path
      end
    end
  end
end