class Estimate < ActiveRecord::Base
#  attr_accessible :accuracy, :facebook_gay_friends, :facebook_male_friends, :gay_friends, :male_friends, :right_percentage
   validates :male_friends, :gay_friends,  :facebook_gay_friends, :accuracy, presence: true, on: :update
   validates :right_percentage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 },if: "accuracy == 'High' || accuracy == 'Low'", on: :update

    validates :male_friends,  :facebook_gay_friends, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
    validates :gay_friends, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :male_friends }, on: :update
end
