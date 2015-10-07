require 'rails_helper'

RSpec.describe "user_requests/show", type: :view do
  before(:each) do
    @user_request = assign(:user_request, UserRequest.create!(
      :booking_key => "Booking Key",
      :name => "Name",
      :hotel => nil,
      :travel_agency => nil,
      :plan => "Plan",
      :mail_note => "MyText",
      :count => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Booking Key/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Plan/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
