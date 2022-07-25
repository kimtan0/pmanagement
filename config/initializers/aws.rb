creds = Aws::Credentials.new('ASIA5KMCHSKMSBPKHKNC', 'KhofqLZzrlYthekvJUpj6QX8b5Vlwq6aEjVUNOkl')

Aws::Rails.add_action_mailer_delivery_method(
  :sns,
  credentials: creds,
  region: 'ap-southeast-1'
)