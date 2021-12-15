require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  

  it { should validate_presence_of(:content) }


  describe "#validations" do

  let(:user){create :user}
  let(:new_user){create :user}
  let(:project){create :project, title: "project b", description: "project be is what i really like to build and create", user: user}
  let(:suggestion){create :suggestion, content: "please make the login button to be nice", project: project, user: new_user, done: false}

    

    context "when a new suggestion is created, regardless of the attribute it is been set to " do
      
      it "done attribute should be false" do
        suggestion.done = true
        expect(Suggestion.find(suggestion.id).done).to eq(false)  
      end
      
    end
  
    # context "when suggestion has already been completed" do
      
    #   it "suggestion should not be valid" do
    #     suggestion.done = true

    #     expect(suggestion).not_to be_valid  
    #   end
      
    # end



    
  end
  

  
  
  
end
