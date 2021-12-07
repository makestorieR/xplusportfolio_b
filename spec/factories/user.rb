FactoryBot.define do
    factory :user do 
      
        password {"password"}
        sequence(:name) {|n| "name #{n}"}
        sequence(:email) { |n| "user#{n}@gmail.com" }

    end
   
end