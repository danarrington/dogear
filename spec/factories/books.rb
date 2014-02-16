FactoryGirl.define do
   factory :book do
      title "Example Book"
      pages 300
      current_page 0

     factory :invalid_book do
       current_page 'letters'
     end
   end

  factory :bookmark do
    association :book
    page 1
  end
end


