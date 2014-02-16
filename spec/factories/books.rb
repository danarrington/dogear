FactoryGirl.define do
   factory :book do
      title "Example Book"
      pages 300
      current_page 0
   end

  factory :bookmark do
    association :book
    page 1
  end
end


