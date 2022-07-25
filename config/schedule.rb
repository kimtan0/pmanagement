set :output, "#{path}/log/cron.log"
env :PATH, ENV['PATH']

every 1.month do
  rake "scheduler:update_due"
end
