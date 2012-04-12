FactoryGirl.define do
  factory :league do
    commissioner
    name Forgery(:name).company_name
    roster_spots 12
    starting_qb 1
    starting_wr 3
    starting_rb 2
    starting_te 1
    starting_k 1
    starting_def 1
    pick 1
    round 1
    
    factory :league_with_teams do
      ignore do
        team_count 12
      end
      
      after_create do |league, evaluator|
        FactoryGirl.create_list(:team, evaluator.team_count, league: league)
      end
    end
  end
end