set :output, "#{path}/log/cron.log"
env :PATH, ENV['PATH']

every 1.minute do
  rake "scheduler:update_due"
end
