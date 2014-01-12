require "spec_helper"

describe TokensController do
  describe "routing" do

    it "routes to #index" do
      get("/tokens").should route_to("tokens#index")
    end

    it "routes to #new" do
      get("/tokens/new").should route_to("tokens#new")
    end

    it "routes to #show" do
      get("/tokens/1").should route_to("tokens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tokens/1/edit").should route_to("tokens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tokens").should route_to("tokens#create")
    end

    it "routes to #update" do
      put("/tokens/1").should route_to("tokens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tokens/1").should route_to("tokens#destroy", :id => "1")
    end

  end
end
