require 'rails_helper'

RSpec.describe "organizations/show", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678"}))
    sign_in @user
    @organization = assign(:organization, Organization.create!(
      :legally_formed => false,
      :email => "Email",
      :telephone_number => "Telephone Number",
      :name => "Name",
      :twitter => "Twitter",
      :facebook => "Facebook",
      :user => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Telephone Number/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Twitter/)
    expect(rendered).to match(/Facebook/)
    expect(rendered).to match(//)
  end
end
