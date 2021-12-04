FactoryBot.define do
  factory :suggestion do
    user { nil }
    project { nil }
    done { false }
  end
end
