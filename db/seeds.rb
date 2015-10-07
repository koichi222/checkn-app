# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
c1 = Company.create! name: "株式会社フォトシンス"
h11 = c1.hotels.create name: "ホテル アケルン 五反田店"
ta = TravelAgency.create! name: "しゃらん"
status = %w(no-guest-info not-assigned assigned checkedin checkedout key canceled)

9.times do |i|
  room = h11.rooms.create!(name: "Room #{i}")

  gi = Guest.create!.guest_infos.create! name: "山田 #{i}郎", phone: "000-0000-000#{i}", email: "u#{i}@example.com"
  h11.bookings.create!(
    travel_agency: ta,
    rooms: [room],
    guest_info: gi,
    status: status[i % status.length]
  )
end
