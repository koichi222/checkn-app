class Booking < ActiveRecord::Base
  belongs_to :guest
  belongs_to :guest_info
  belongs_to :travel_agency
  belongs_to :hotel
  has_many :booking_rooms
  has_many :rooms, through: :booking_rooms
  has_many :user_requests
  validates :status, inclusion: { in: %w(no-guest-info not-assigned assigned checkedin checkedout key canceled) }

  # 実際には鍵のない発行
  def temporary_akerun!(guest, access_token)
    res = AkerunClient.grant(
      access_token: access_token,
      user_id: guest.akerun_user_key,
      start_date: checkin,
      end_date: checkout
    )
    update_attributes temporary_akerun_key: res[:id], guest_id: guest.id
  end

  # チェックイン可能か？
  def can_checkin?
    %w(assigned).include?(status) && checkin <= Time.now
  end

  # チェックアウト可能か？
  def can_checkout?
    %w(checkedin key).include?(status)
  end

  # チェックイン処理
  def checkin!(options={})
    if temporary_akerun_key.present?
      res = AkerunClient.revoke(
        access_token: options[:access_token],
        id: temporary_akerun_key
      )
      update_attributes temporary_akerun_key: nil
    end
    booking_rooms.each {|r| r.checkin!(options[:access_token])}
    update_attributes status: (options[:status] || 'checkedin')
  end

  # チェックアウト処理
  def checkout!(options={})
    if temporary_akerun_key.present?
      res = AkerunClient.revoke(
        access_token: options[:access_token],
        id: temporary_akerun_key
      )
      update_attributes temporary_akerun_key: nil
    end
    booking_rooms.each {|r| r.checkout!(options[:access_token])}
    update_attributes status: (options[:status] || 'checkedout')
  end

end
