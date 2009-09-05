Factory.define(:placement) do |placement|
  placement.section "A section"
  placement.ad_type "768x90 Banner"
  placement.start_date 1.day.from_now
  placement.end_date 15.days.from_now
end

Factory.define(:buy) do |buy|
  buy.site { |site| site.association(:site) }
  buy.placements { |placements| [placements.association(:placement)] }
end

Factory.define(:plan) do |plan|
  plan.advertiser_name "Bossy Kitten"
  plan.buys { |buys| [buys.association(:buy)]  }
end

Factory.define(:site) do |site|
  site.name "Facebook"
  site.url "http://www.facebook.com"
  site.billing_contact "Mark Zuckerberg"
end