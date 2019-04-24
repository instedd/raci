require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678", confirmed_at: DateTime.now}))
    sign_in @user
    assign(:project, Project.new(
      :name => "MyString",
      :description => "MyText",
      :organization_id => nil,
      :published => false
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "textarea#project_description[name=?]", "project[description]"

      assert_select "select#project_location_ids[name=?]", "project[location_ids][]"
    end
  end
end
