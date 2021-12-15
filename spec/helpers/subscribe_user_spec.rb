require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SubscribeUserHelper. For example:
#
# describe SubscribeUserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SubscribeUserHelper, type: :helper do
  describe "suscrbe followers" do

    before do 
        a_cover = create :anticipation_cover
        @user = create :user, name: "peter"
        
        @searched_user = create :user, name: "paul obi"
        @user.follow @searched_user
        @anticipation = create :anticipation, body: "Working on a todo application", user: @searched_user, due_date: Date.today, anticipation_cover: a_cover
      
        # @user.follow @anticipation
    end

      it "increment anticipation suscribers by 1" do
          expect{subscribe_user(@anticipation)}.to  change{@anticipation.followers.count}.by(1)
      end
      
  end
  
end
