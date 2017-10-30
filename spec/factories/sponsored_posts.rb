FactoryGirl.define do
    factory :sponsored_post do
        title RandomData.random_sentence
        body RandomData.random_paragraph
        price RandomData.random_number
        topic
    end
end