class BookingRoom < ActiveRecord::Base
  belongs_to :booking
  belongs_to :room

  # 鍵発行
  def checkin!(access_token)
    if akerun_grant_key.blank?
      res = AkerunClient.grant(
        access_token: access_token,
        user_id: booking.guest.akerun_user_key,
        akerun_id: room.akerun_key,
        start_date: booking.checkin,
        end_date: booking.checkout
      )
      if res[:success]
        update_attributes akerun_grant_key: res[:id]
      else
        # noop
      end
    else
      update_key!(access_token)
    end
  end

  # 鍵の期間を更新
  def update_key!(access_token)
    res = AkerunClient.update(
      access_token: access_token,
      id: akerun_grant_key,
      start_date: booking.checkin,
      end_date: booking.checkout
    )
  end

  def checkout!(access_token)
    if akerun_grant_key.present?
      res = AkerunClient.revoke(
        access_token: access_token,
        id: akerun_grant_key
      )
      if res[:success]
        update_attributes akerun_grant_key: nil
      else
        # noop
      end
    end
  end
end
