namespace :scheduler do
  
  desc "Update units due"
  task update_due: :environment do
    Unit.where(user_type: 'client').each do |u|
      u.update(due_amount: (u.due_amount + u.rental_amount))
    end
  end
end