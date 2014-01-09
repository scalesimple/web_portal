require "spec_helper"

describe AccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/accounts").should route_to("accounts#index")
    end

    it "routes to #new" do
      get("/accounts/new").should route_to("accounts#new")
    end

    it "routes to #show" do
      get("/accounts/1").should route_to("accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accounts/1/edit").should route_to("accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accounts").should route_to("accounts#create")
    end

    it "routes to #update" do
      put("/accounts/1").should route_to("accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accounts/1").should route_to("accounts#destroy", :id => "1")
    end

  end
end
