class Hotel < ActiveRecord::Base
  belongs_to :company
  has_many :rooms
  has_many :bookings
  has_many :touch_points

  def import_akeruns!(access_token)
    res = AkerunClient.hotel_akeruns(
      access_token: access_token,
      hotel_id: akerun_hotel_key
    )

    # 部屋の読み込み
    rooms.where(akerun_key: nil).destroy_all
    _rooms = rooms.map{|r| [r.akerun_key.to_s, r]}.to_h
    res[:akeruns].select{|a| a[:device_type] == 'akerun'}.each do |a|
      if _rooms[a[:id].to_s]
        _rooms[a[:id].to_s].update_attributes name: a[:name]
        _rooms.delete a[:id].to_s
      else
        self.rooms.create!(akerun_key: a[:id], name: a[:name])
      end
    end
    _rooms.values.each(&:destroy)

    # Touchpoint
    touch_points.destroy_all
    res[:akeruns].select{|a| a[:device_type] == 'touchpoint'}.each do |a|
      touch_points.create! akerun_key: a[:id], name: a[:name], device_type: /(アウト|あうと|out)/i.match(a[:name]) ? "checkout" : "checkin"
    end
  end

end
