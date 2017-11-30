task create_stripe_plans: :environment do
  Plan.create({
    stripe_id: 'standard',
    name: 'Standard',
    price: 9.99,
    interval: 'month',
    features: ['All'].join("\n\n"),
    display_order: 1
  })
end