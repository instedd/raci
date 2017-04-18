require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678"}))
    sign_in @user
    assign(:projects, [
      Project.create!(
        :name => "Name",
        :description => "MyText",
        :organization => create_organization({user: @user}),
        :location => "Location",
        :published => false
      ),
      Project.create!(
        :name => "Name",
        :description => "MyText",
        :organization => create_organization({user: @user}),
        :location => "Location",
        :published => false
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
