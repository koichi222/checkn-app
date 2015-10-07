require 'rails_helper'

RSpec.describe "guests/edit", type: :view do
  before(:each) do
    @guest = assign(:guest, Guest.create!(
      :akerun_user_id => "MyString",
      :name => "MyString",
      :zip => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :phone => "MyString",
      :sex => 1
    ))
  end

  it "renders the edit guest form" do
    render

    assert_select "form[action=?][method=?]", guest_path(@guest), "post" do

      assert_select "input#guest_akerun_user_id[name=?]", "guest[akerun_user_id]"

      assert_select "input#guest_name[name=?]", "guest[name]"

      assert_select "input#guest_zip[name=?]", "guest[zip]"

      assert_select "input#guest_address1[name=?]", "guest[address1]"

      assert_select "input#guest_address2[name=?]", "guest[address2]"

      assert_select "input#guest_phone[name=?]", "guest[phone]"

      assert_select "input#guest_sex[name=?]", "guest[sex]"
    end
  end
end
