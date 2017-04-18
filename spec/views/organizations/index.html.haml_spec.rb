require 'rails_helper'

RSpec.describe "organizations/index", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678"}))
    sign_in @user
    assign(:organizations, [
      Organization.create!(
        :legally_formed => false,
        :email => "Email",
        :telephone_number => "Telephone Number",
        :name => "Name",
        :twitter => "Twitter",
        :facebook => "Facebook",
        :user => @user
      ),
      Organization.create!(
        :legally_formed => false,
        :email => "Email",
        :telephone_number => "Telephone Number",
        :name => "Name2",
        :twitter => "Twitter",
        :facebook => "Facebook",
        :user => @user
      )
    ])
  end

  it "renders a list of organizations" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Telephone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => "admin@example.com", :count => 2
  end
end
