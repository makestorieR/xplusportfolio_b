class Technology < ApplicationRecord

	has_many :tools,  dependent: :destroy
end
