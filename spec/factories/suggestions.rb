FactoryBot.define do
  factory :suggestion do
    user { nil }
    project { nil }
    done { false }
    content {"I am suggestiong you create a login system"}
  end
end
