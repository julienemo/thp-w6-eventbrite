#Attendance.destroy_all
#Event.destroy_all
#User.destroy_all
separator = "-*" * 40

puts separator
puts ""
puts "Previous record deleted."


3.times do
  User.create(first_name: Faker::Name.first_name,
  email: Faker::Internet.email,
  password: Faker::Code.nric)
end
puts "#{User.all.length} fake user profiles created."

users = User.all.map{|u| u.id}
users.each do |u|
  2.times do
    Event.create(admin_id: u,
    location: Faker::Address.city,
    title: Faker::Book.title,
    description: Faker::Lorem.sentence(10),
    price: rand(1..1000),
    start_time: Faker::Time.between(DateTime.now+1, DateTime.now + 6000),
    duration: rand(1..3)*5*600)
  end
end
puts "#{Event.all.length} events created, 2 per admin."

events = Event.all.map{|e| e}
users.each do |u|
  events.each do |e|
    unless e.admin_id == u
      Attendance.create(event_id: e.id, participant_id: u)
    end
  end
end
puts "#{Attendance.all.length} participations created. Everybody has participated in all events not created by oneself."
puts ""
puts separator
