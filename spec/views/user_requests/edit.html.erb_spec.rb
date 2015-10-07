require 'rails_helper'

RSpec.describe "user_requests/edit", type: :view do
  before(:each) do
    @user_request = assign(:user_request, UserRequest.create!(
      :booking_key => "MyString",
      :name => "MyString",
      :hotel => nil,
      :travel_agency => nil,
      :plan => "MyString",
      :mail_note => "MyText",
      :count => 1
    ))
  end

  it "renders the edit user_request form" do
    render

    assert_select "form[action=?][method=?]", user_request_path(@user_request), "post" do

      assert_select "input#user_request_booking_key[name=?]", "user_request[booking_key]"

      assert_select "input#user_request_name[name=?]", "user_request[name]"

      assert_select "input#user_request_hotel_id[name=?]", "user_request[hotel_id]"

      assert_select "input#user_request_travel_agency_id[name=?]", "user_request[travel_agency_id]"

      assert_select "input#user_request_plan[name=?]", "user_request[plan]"

      assert_select "textarea#user_request_mail_note[name=?]", "user_request[mail_note]"

      assert_select "input#user_request_count[name=?]", "user_request[count]"
    end
  end
end
