class UserRequest < ActiveRecord::Base
  belongs_to :booking
  belongs_to :guest

  def send_request!(access_token)
    res = AkerunClient.new.execute :introduce_email,
      "access_token" => access_token,
      "parent_booking_id" => key,
      "date" => booking.checkin,
      "name" => name,
      "media" => booking.travel_agency.try(:name),
      "plan" => booking.plan,
      "hotel_id" => booking.hotel.try(:id),
      "mail_note" => mail_note,
      "count" => count

    if res['success']
      ActionMailer::Base.mail(
        to: email,
        from: "akerun-hotel@photosynth.co.jp",
        subject: res["subject"],
        content_type: "text/html",
        body: res["body"].html_safe
      ).deliver_now
    else
      logger.error "introduce_email: #{res.inspect}"
    end
  end

  def register(guest, access_token)
    self.update_attributes guest_id: guest.id
    logger.error "user_req register: #{access_token}"
    booking.temporary_akerun!(guest, access_token)
  end

  def guest_info_url
    "#{WEB_ROOT}/guestbooks/#{self.booking.key}"
  end
end
