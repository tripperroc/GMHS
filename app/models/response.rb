class Response < ActiveRecord::Base
  #belongs_to :facebook_user
  has_one :estimate
  has_one :facebook_response

  validates :twelve_drinks, :drink_frequency_yearly, :drink_frequency_daily, :binge_drink_yearly, presence: true, if: "one_drink == 'Yes'", on: :update

  validates :binge_drink_quickly_yearly, presence: true, if: "one_drink == 'Yes' && !(binge_drink_yearly == 'Never in the last year')", on: :update

  validates :smoked_yearly, presence: true, if: "smoked_last_year == 'Yes'", on: :update

  validates :violence_age_first, :violence_age_most_recent, :violence_victim_parents, :violence_ever_neglected, :violence_ever_spouse, :violence_ever_other, :violence_ever_mugged, presence: true, if: "violence_victim_ever == 'Yes'", on: :update

  #validates :ever_suicidal, presence: true, if: "ever_suicidal == 'Yes'", on: :update


  
  validates :age, :birth_sex, presence: true, on: :update
  #validates :age, :birth_sex, :marital_status, :latino, :num_children, :highest_grade_level_completed, :income, :health_care_provider, :have_health_plan, :general_health, :height_feet, :height_inches, :weight, :one_drink, :smoked_last_year, :violence_victim_ever, :sex_feelings, :sex_who, :sex_category, :discrimination_insurance, :discrimination_how_treated, :discrimination_public, :discrimination_job, :discrimination_bullied, :ever_aids, :ever_suicidal, :frequency_facebook, :frequency_twitter, :frequency_google_plus, :frequency_myspace, :frequency_linkedin, :frequency_other, :ever_tumblr, :ever_trevorspace, :ever_grindr, :ever_scruff, :ever_jackd,  :ever_hornet,  :ever_yelp,  :ever_foursquare, :ever_flickr,  :ever_youtube,  :ever_pinterest, :ever_instagram, :ever_other, presence: true, on: :update
 
end
