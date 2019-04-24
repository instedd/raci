require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @user = assign(:user, create_user({email: "admin@example.com", password: "12345678", admin: true, confirmed_at: DateTime.now}))
    sign_in @user
    @project = assign(:project, Project.create!(
      :name => "MyString",
      :description => "MyText",
      :organization => create_organization({user: @user}),
      :published => false,
      :start_date => Time.now,
      :end_date => Time.now,
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "textarea#project_description[name=?]", "project[description]"

      assert_select "select#project_location_ids[name=?]", "project[location_ids][]"
    end
  end
end
