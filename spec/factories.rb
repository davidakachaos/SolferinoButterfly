FactoryGirl.define do
  factory :season do
    serie nil
    state 1
    number 1
    tvdb_id 1
  end
  factory :episode do
    name "MyString"
    serie nil
    state 1
    number 1
    tvdb_id 1
  end
  factory :series, class: 'Serie' do
    actors "MyText"
    airs_dayofweek "MyString"
    airs_time "MyString"
    content_raiting "MyString"
    first_aired "2016-04-18"
    genre "MyString"
    imdb_id 1
    language "MyString"
    network "MyString"
    network_id 1
    overview "MyText"
    rating "MyString"
    raring_count 1
    runtime "MyString"
    series_id 1
    series_name "MyString"
    status "MyString"
    added "2016-04-18"
    added_by "MyString"
    banner "MyString"
    fanart "MyString"
    last_updated "2016-04-18 20:47:50"
    poster "MyString"
    zap2it_id 1
    name "MyString"
  end
end
