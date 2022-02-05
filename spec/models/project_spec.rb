require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) } 
  it { should belong_to(:anticipation) } 
  it { should have_many(:comments) }
  it { should have_many(:suggestions) } 
end
