require 'rails_helper'

RSpec.describe "guests/index", type: :view do
  before(:each) do
    assign(:guests, [
      Guest.create!(
        :akerun_user_id => "Akerun User",
        :name => "Name",
        :zip => "Zip",
        :address1 => "Address1",
        :address2 => "Address2",
        :phone => "Phone",
        :sex => 1
      ),
      Guest.create!(
        :akerun_user_id => "Akerun User",
        :name => "Name",
        :zip => "Zip",
        :address1 => "Address1",
        :address2 => "Address2",
        :phone => "Phone",
        :sex => 1
      )
    ])
  end

  it "renders a list of guests" do
    render
    assert_select "tr>td", :text => "Akerun User".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
