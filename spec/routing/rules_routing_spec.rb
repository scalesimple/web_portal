require "spec_helper"

describe RulesController do
  describe "routing" do

    it "routes to #index" do
      get("/rules").should route_to("rules#index")
    end

    it "routes to #new" do
      get("/rules/new").should route_to("rules#new")
    end

    it "routes to #show" do
      get("/rules/1").should route_to("rules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rules/1/edit").should route_to("rules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rules").should route_to("rules#create")
    end

    it "routes to #update" do
      put("/rules/1").should route_to("rules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rules/1").should route_to("rules#destroy", :id => "1")
    end

  end
end
