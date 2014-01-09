require "spec_helper"

describe RulesetMailer do
  describe "ruleset_active" do
    let(:mail) { RulesetMailer.ruleset_active }

    it "renders the headers" do
      mail.subject.should eq("Ruleset active")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
