class GuestInfo < ActiveRecord::Base
  belongs_to :guest
  has_many :bookings
end
