require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      it "creates the organization" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, params: {"user"=>{"email"=>"admin@raci.org", "password"=>"12345678", "password_confirmation"=>"12345678",
            "organization_attributes"=>{"name"=>"RACI", "telephone_number"=>"45678", "email"=>"info@raci.org", "twitter"=>"raci", "facebook"=>"", "legally_formed"=>"1"}}}
        expect(Organization.count).to eq(1)
      end

      it "creates the user" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, params: {"user"=>{"email"=>"admin@raci.org", "password"=>"12345678", "password_confirmation"=>"12345678",
            "organization_attributes"=>{"name"=>"RACI", "telephone_number"=>"45678", "email"=>"info@raci.org", "twitter"=>"raci", "facebook"=>"", "legally_formed"=>"1"}}}
        expect(User.count).to eq(1)
      end
    end
  end
end
