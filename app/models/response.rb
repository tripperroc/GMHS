# -*- coding: utf-8 -*-
class Response < ActiveRecord::Base
  #belongs_to :facebook_user
  has_one :estimate
  has_one :facebook_response

  validates :twelve_drinks, :drink_frequency_yearly, :drink_frequency_daily, :binge_drink_yearly, presence: true, if: "one_drink == 'Yes'", on: :update

   validates :drink_frequency_daily, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: "one_drink == 'Yes'", on: :update

  validates :binge_drink_quickly_yearly, presence: true, if: "one_drink == 'Yes' && !(binge_drink_yearly == 'Never in the last year')", on: :update

  validates :smoked_yearly, presence: true, if: "smoked_last_year == 'Yes'", on: :update

  validates :violence_age_first, :violence_age_most_recent, :violence_victim_parents, :violence_ever_neglected, :violence_ever_spouse, :violence_ever_other, :violence_ever_mugged, presence: true, if: "violence_victim_ever == 'Yes'", on: :update

  #validates :ever_suicidal, presence: true, if: "ever_suicidal == 'Yes'", on: :update


  
  #validates :age, :birth_sex, presence: true, on: :update
  validates :age, :birth_sex, :marital_status, :latino, :num_children, :highest_grade_level_completed, :income, :health_care_provider, :have_health_plan, :general_health, :height_feet, :height_inches, :weight, :one_drink, :smoked_last_year, :ever_self_harm, :ever_seriously_ill, :violence_victim_ever, :care_swear, :care_fear, :care_harm,:sex_feelings, :sex_who, :sex_category, :discrimination_insurance, :discrimination_how_treated, :discrimination_public, :discrimination_job, :discrimination_bullied, :ever_aids, :ever_suicidal, :frequency_facebook, :frequency_twitter, :frequency_google_plus, :frequency_myspace, :frequency_linkedin, :frequency_other, :ever_tumblr, :ever_trevorspace, :ever_grindr, :ever_scruff, :ever_jackd,  :ever_hornet,  :ever_yelp,  :ever_foursquare, :ever_flickr,  :ever_youtube,  :ever_pinterest, :ever_instagram, :ever_other, presence: true, on: :update

  validates :age, :num_children, :height_feet, :height_inches, :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
  validate :checkboxes, on: :update

  def checkboxes
   boxes = [[:gender, [[gender_male, :gender_male],
              [gender_female, :gender_female],
              [gender_mtf, :gender_mtf],
              [gender_ftm,:gender_ftm],
              [gender_other,:gender_other]]],
    [:ethnicity, [[namerican,:namerican], 
                  [asian, :asian], 
                  [aamerican, :aamerican],
                  [pacific,:pacific],
                  [eamerican, :eamerican]]],

    [:employment, [[work_more_than_35,:work_more_than_35],
                  [work_less_than_35,:work_less_than_35],
                  [work_yes_ill,:work_yes_ill],
                  [work_yes_vacation,:work_yes_vacation],
                  [work_yes_absent,:work_yes_absent],
                  [unemployed_looking,:unemployed_looking],
                  [unemployed_not_looking,:unemployed_not_looking],
                  [unemployed_disabled,:unemployed_disabled],
                  [retired,:retired],
                  [school_fulltime,:school_fulltime],
                  [school_parttime,:school_parttime],
                  [school_break,:school_break],
                  [homemaker,:homemaker],
                  [work_else,:work_else]]]]
 
     drugs = [:drugs,  [[sedatives_last_year,:sedatives_last_year],
               [tranquilizers_last_year,:tranquilizers_last_year],
               [tranquilizers_last_year,:painkillers_last_year],
               [stimulants_last_year,:stimulants_last_year],
               [marijuana_last_year, :marijuana_last_year],
               [hallucinogens_last_year, :hallucinogens_last_year],
               [inhalents_last_year, :inhalents_last_year],
               [heroin_last_year, :heroin_last_year],
               [drugs_other_last_year,:drugs_other_last_year]]]
  
   

   suicidal = [:suicidal, [[suicidal_thought, :suicidal_thought],
                [suicidal_plan,:suicidal_plan],
                [suicidal_note_hidden,:suicidal_note_hidden],
                [suicidal_note_open,:suicidal_note_open],
                [suicidal_method,:suicidal_method],
                [suicidal_attempt,:suicidal_attempt],
                [suicidal_medical,:suicidal_medical],
                [suicidal_not_serious,:suicidal_not_serious]]]

    boxes.each do |name, items| 
        at_least_one_checked name, items
    end
    if ever_suicidal == "Yes"
        at_least_one_checked suicidal[0], suicidal[1]
    end
  end

  def at_least_one_checked (name, boxes)
    x = false
    boxes.each do |val, field|
      x = (val or x)
      logger.debug x
    end
    if !x
      errors.add(name, "can't be blank.")
      boxes.each do |val, field| 
        errors.add(field, "")
      end
    end
  end
  



   

end
