creds = Aws::Credentials.new('AKIA33IFZ26W2O4EIJEN', 'mbtU6n7Qn32TfRHjZR3PJfEFwi+UU4MY3hFwWXpm')

Aws::Rails.add_action_mailer_delivery_method(
  :sns,
  credentials: creds,
  region: 'us-east-1'
)