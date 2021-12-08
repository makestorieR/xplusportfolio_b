require 'rails_helper'

RSpec.describe Anticipation, type: :model do
  it { should belong_to(:user) } 
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:due_date) }
  it { should have_many(:comments) } 
  it { should belong_to(:anticipation_cover)}


  context "when the due date changes" do
    let(:user){create :user}
    let(:anticipation_cover){create :anticipation_cover}
    let(:anticipation){create :anticipation, body: "working on a react app", due_date: Date.today, anticipation_cover: anticipation_cover, user: user}
    

    it "penilize the user by deducting 50 repu coin" do
      anticipation.due_date = Date.tomorrow
      expect(User.find(user.id).repu_coin).to eq(50)  
    end
    
  end
  
end
