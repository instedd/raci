require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678"}))
    sign_in @user
    @project = assign(:project, Project.create!(
      :name => "MyString",
      :description => "MyText",
      :organization => create_organization({user: @user}),
      :location => "MyString",
      :published => false
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "textarea#project_description[name=?]", "project[description]"

      assert_select "input#project_organization_id[name=?]", "project[organization_id]"

      assert_select "input#project_location[name=?]", "project[location]"

      assert_select "input#project_published[name=?]", "project[published]"
    end
  end
end
