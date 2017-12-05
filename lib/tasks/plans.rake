task plans: :environment do
  p = SubscriptionPlan.create!({
    amount: '9.99',
    currency: '&pound',
    interval: 'month',
    stripe_id: 'standard',
    name: 'Standard'
  })
  puts "Created #{p.name} plan"
end