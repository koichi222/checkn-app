require 'rails_helper'

RSpec.describe "user_requests/index", type: :view do
  before(:each) do
    assign(:user_requests, [
      UserRequest.create!(
        :booking_key => "Booking Key",
        :name => "Name",
        :hotel => nil,
        :travel_agency => nil,
        :plan => "Plan",
        :mail_note => "MyText",
        :count => 1
      ),
      UserRequest.create!(
        :booking_key => "Booking Key",
        :name => "Name",
        :hotel => nil,
        :travel_agency => nil,
        :plan => "Plan",
        :mail_note => "MyText",
        :count => 1
      )
    ])
  end

  it "renders a list of user_requests" do
    render
    assert_select "tr>td", :text => "Booking Key".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Plan".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
