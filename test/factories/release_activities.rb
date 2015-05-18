FactoryGirl.define do
  factory :release_activity do
    outcome 'success'
    release_date DateTime.now - 2.days
    log 'It all went well'
  end

end
