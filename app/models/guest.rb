class Guest < ActiveRecord::Base
  has_many :guest_infos
end
