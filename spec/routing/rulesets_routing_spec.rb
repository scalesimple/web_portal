require "spec_helper"

describe RulesetsController do
  describe "routing" do

    it "routes to #index" do
      get("/rulesets").should route_to("rulesets#index")
    end

    it "routes to #new" do
      get("/rulesets/new").should route_to("rulesets#new")
    end

    it "routes to #show" do
      get("/rulesets/1").should route_to("rulesets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rulesets/1/edit").should route_to("rulesets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rulesets").should route_to("rulesets#create")
    end

    it "routes to #update" do
      put("/rulesets/1").should route_to("rulesets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rulesets/1").should route_to("rulesets#destroy", :id => "1")
    end

  end
end
