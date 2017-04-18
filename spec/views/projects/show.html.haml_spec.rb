require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678"}))
    sign_in @user
    @project = assign(:project, Project.create!(
      :name => "Name",
      :description => "MyText",
      :organization => create_organization({user: @user}),
      :location => "Location",
      :published => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/false/)
  end
end
