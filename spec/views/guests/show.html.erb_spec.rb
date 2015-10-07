require 'rails_helper'

RSpec.describe "guests/show", type: :view do
  before(:each) do
    @guest = assign(:guest, Guest.create!(
      :akerun_user_id => "Akerun User",
      :name => "Name",
      :zip => "Zip",
      :address1 => "Address1",
      :address2 => "Address2",
      :phone => "Phone",
      :sex => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Akerun User/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Address1/)
    expect(rendered).to match(/Address2/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/1/)
  end
end
