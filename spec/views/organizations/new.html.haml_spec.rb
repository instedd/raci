require 'rails_helper'

RSpec.describe "organizations/new", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678", confirmed_at: DateTime.now}))
    sign_in @user
    assign(:organization, Organization.new(
      :legally_formed => false,
      :email => "MyString",
      :telephone_number => "MyString",
      :name => "MyString",
      :twitter => "MyString",
      :facebook => "MyString",
      :user => @user
    ))
  end

  it "renders new organization form" do
    render

    assert_select "form[action=?][method=?]", organizations_path, "post" do

      assert_select "input#organization_legally_formed[name=?]", "organization[legally_formed]"

      assert_select "input#organization_email[name=?]", "organization[email]"

      assert_select "input#organization_telephone_number[name=?]", "organization[telephone_number]"

      assert_select "input#organization_name[name=?]", "organization[name]"

      assert_select "input#organization_twitter[name=?]", "organization[twitter]"

      assert_select "input#organization_facebook[name=?]", "organization[facebook]"
    end
  end
end
