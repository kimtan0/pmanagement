class UnitController < ApplicationController

  def dashboard
    @unit = Unit.find(cookies[:unit_id])

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

end