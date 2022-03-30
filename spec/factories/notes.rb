FactoryBot.define do
  factory :note do
    content { "MyText" }
    user { nil }
    project { nil }
    seen { false }
  end
end
