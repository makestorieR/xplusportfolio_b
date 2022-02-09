require 'rails_helper'

RSpec.describe ProjectPhoto, type: :model do
 it { should validate_presence_of(:img_url) }
end
