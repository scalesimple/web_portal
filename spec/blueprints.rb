Sham.define do
  title { Faker::Lorem.words(5).join(' ')[0..47] }
  short_title { Faker::Lorem.words(2).join(' ')[0..23] }
  login { Faker::Lorem.words(2).join + Time.now.utc.to_i.to_s }
  email { Faker::Lorem.words(2).join('_') + "@example.com" }
  date {Date.today}
  dateTime {DateTime.now}
  thumbnail {Faker::Internet.url+"/"+Faker::Lorem.words(1).join+".jpg"}
  random_date { Date.civil((1990...2009).to_a.sample, (1..12).to_a.sample, (1..28).to_a.sample)}
end

Ruleset.blueprint do
  name { []  }
end

Hostname.blueprint do 
  name { [] }
  ruleset_id { [] }
  active_ruleset_id { [] }
end

Account.blueprint do 
  user { User.make }
  name { "Account " + Time.now.to_s }
  primary_contact { "Some Contact" }
  primary_contact_email { Sham.email }
  primary_phone { "212-555-1212" } 
end

User.blueprint do
  email { Sham.email }
  password { "password" }
  password_confirmation { "password" }
end

