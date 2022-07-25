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

  def logout
    cookies.delete :unit_id
    redirect_to unit_login_path
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
    @due =  (@unit.due_amount / 100).to_s + "$"
  end

  def payment_process
    @unit = Unit.find(cookies[:unit_id])
    Payment.create(date: Date.today, amount: params[:amount], unit: @unit)
    @unit.update(due_amount: @unit.due_amount - (params[:amount].to_i)*100)
    redirect_to unit_dashboard_path
  end

  def complaint
    unit = Unit.find(cookies[:unit_id])
    @complaint = Complaint.new
  end

  def complaint_process
    unit = Unit.find(cookies[:unit_id])
    complaint = Complaint.create(complaint_params.merge(unit_id: unit.id))

    s3 = Aws::S3::Resource.new(
    access_key_id: 'ASIA5KMCHSKMSBPKHKNC',
    secret_access_key: 'KhofqLZzrlYthekvJUpj6QX8b5Vlwq6aEjVUNOkl',
    session_token: "FwoGZXIvYXdzEG0aDC+NS7wSi5aJWQPkQiLJAU/68li9PpsjksmLmIXgjOcB6UJxwZNGdvOrvUwLYgpn/zqZ++ygnMkeHwSVHsvY25MnO+1z3sZ3M6hub+VCM57kLkXxNKah01xqFaQJfuYRnthPvtPYYhYrwQMP6D3pW74hcHU+zPmY1orRiYfQoQaGOJu0JmZJY3kOloVMU7zcw3v7yeUeNQALYRK4As2hsUbQddwgIZSU7JCbFsGAHyp8AtyYqp+dLJpKtXtGsoxs6G/IiradjIAxe67ftvxC+sI/RrVtKg15Dijv+vmWBjItyPmbNly4niLWL3f6c3l7qkRZkun2EqmfgOdWMDXeTgvAVbCVzUHvmMYWLjtG",
    region: 'us-east-1'
    )
    dates = []
    keys = []
    images = s3.bucket('pmanagement0').objects.select do |object| 
      keys << object.key
      date = object.last_modified.to_s
      dates << DateTime.new(date[0..3].to_i, date[5..6].to_i, date[8..9].to_i, date[11..12].to_i, date[14..15].to_i, date[17..18].to_i, date[20..22])
    end

    latest_date = DateTime.new(2000, 07, 25, 14, 48, 25, 'UTC')
    index = 0
    dates.each_with_index do |d,i|
      if d > latest_date
        latest_date = d
        index = i
      end
    end
     url = "https://dazuk5tleph55.cloudfront.net/" + keys[index].to_s



    sns = Aws::SNS::Resource.new(
      access_key_id: "ASIA5KMCHSKMSBPKHKNC",
      secret_access_key: "KhofqLZzrlYthekvJUpj6QX8b5Vlwq6aEjVUNOkl",
      session_token: "FwoGZXIvYXdzEG0aDC+NS7wSi5aJWQPkQiLJAU/68li9PpsjksmLmIXgjOcB6UJxwZNGdvOrvUwLYgpn/zqZ++ygnMkeHwSVHsvY25MnO+1z3sZ3M6hub+VCM57kLkXxNKah01xqFaQJfuYRnthPvtPYYhYrwQMP6D3pW74hcHU+zPmY1orRiYfQoQaGOJu0JmZJY3kOloVMU7zcw3v7yeUeNQALYRK4As2hsUbQddwgIZSU7JCbFsGAHyp8AtyYqp+dLJpKtXtGsoxs6G/IiradjIAxe67ftvxC+sI/RrVtKg15Dijv+vmWBjItyPmbNly4niLWL3f6c3l7qkRZkun2EqmfgOdWMDXeTgvAVbCVzUHvmMYWLjtG",
      region: 'us-east-1'
      )

    topic = sns.topic('arn:aws:sns:us-east-1:915638031001:testTopic')

    topic.publish({
      message: 'Client Complaint | Client Unit Number: '+ unit.unit_number.to_s + ' | Tenant Name: '+ unit.tenant_name+' | Complaint Description: '+params[:complaint][:description] +' | Complaint Image URL: '+url
    })


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