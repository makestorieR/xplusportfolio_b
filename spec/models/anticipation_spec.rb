require 'rails_helper'

RSpec.describe Anticipation, type: :model do
  it { should belong_to(:user) } 
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:due_date) }
  it { should have_many(:comments) } 
end
