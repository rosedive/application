FactoryBot.define do
    factory :task do
      id { 1 }
      name { "MyString" }
      status { "MyString" }
      content { "MyString" }
      priority { "MyString" }
      start_date { "2019-09-17" }
      end_date { "2019-09-17" }
    end
  end
  