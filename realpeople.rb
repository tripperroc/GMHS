# -*- coding: utf-8 -*-
class Person   
  def initialize(*args)
     @who_recruit = Array.new
     @recruiters = Array.new
     @name = args[0]
     @email = args[1]
  end

  def update_profile(orientation,success)
    @orientation = orientation
    @success = success
  end

  def reset_who
    @who_recruit = Array.new
  end

  def add_link(link)
    @who_recruit << link
  end

  def to_s
    "#{@email} (#{@name})"
  end

  def add_recruiter(recruiter)
    @recruiters << recruiter
  end
  attr_reader :who_recruit
  attr_reader :name
  attr_reader :email
  attr_reader :orientation
  attr_reader :success
  attr_reader :recruiters
end

recruits = [['Homer','Ned', 'Gay', true],['Homer','Bart', 'Bisexual', true],['Homer','Lenny', 'Bisexual', true],
                ['Homer','Skinner', 'Gay', false], # should not save; too many recruits
                ['Bart','Milhaus', 'Gay', true],
                ['Bart','Fry', 'Bisexual', true],
                ['Bart','Skinner', 'Bisexual', true], # should save now, even though Skinner was rejected before
                ['Bart','Lisa','Bisexual',false], # should not save; too many recruits
                ['Skinner','Milhaus', 'Gay', false], # should not save; Milhaus already recruited
                ['Skinner','Otto', 'Bisexual', false], # with test limit of 16 this should reject

                ['Otto', 'Bart', 'Gay', false],  # should not save; Bart already recruited
                ['Maggie', 'Grandpa', 'Heterosexual (straight)', true],
                ['Maggie','Homer', 'Bisexual', false],
                ['Maggie', 'Troy', 'Bisexual', false],
                ['Grandpa','Marge', 'Heterosexual (straight)', true],
                ['Grandpa', 'Lisa', 'Bisexual', false],
                ['Grandpa','Burns', 'Heterosexual (straight)', true],
                ['Marge','Selma', 'Heterosexual (straight)', true],
                ['Marge','Patty', 'Heterosexual (straight)', true],
                ['Patty','Zoidberg', 'Heterosexual (straight)', false]] # with test limit of 16 this should reject

real_people = [['Homer', "Sandy Dechert", "sandydech@gmail.com"],
                   ['Ned', "Suzanne Bettina Gleason", "suzannebgleason@gmail.com"],
                   ['Bart', "Paul Hauk", "whorf007@verizon.net"],
                   ['Lenny', "Charles Kamen-Mohn", "Charles_Kamen@URMC.Rochester.edu"],
                   ['Milhaus', "Darren Kuhnau", "kuhnau@aya.yale.edu"],
                   ['Fry', "Jubin Matloubieh", "jubinx@gmail.com"],
                   ['Skinner', "Jacque Day Pallone", "jrevolver@gmail.com"],
                   ['Lisa', "Emily Queenan", "emilyqueenan@gmail.com"],
                   ['Milhaus', "Jason Roberts", "jroberts99@gmail.com"],
                   ['Otto', "Gene Homan", "ornus44@gmail.com"],
                   ['Maggie', "Anna Shives", "onemoreblue@gmail.com"],
                   ['Grandpa', "Jeremy Shives", "jeremy.shives@gmail.com"],
                   ['Marge', "Tim Southern", "Transamtim@yahoo.com"],
                   ['Troy', "Banu Çankaya", "BCANKAYA@ku.edu.tr"],
                   ['Burns', "Faith Murphy", "faithmurphy7@gmail.com"],
                   ['Selma', "Sapna Ganesh", "g1368@rit.edu"],
                   ['Patty', "Hitesh Vyas", "hv5451@rit.edu"],
                   ['Zoidberg', "Jeremy Dominijanni", "jmd8058@rit.edu"]]

pmap = Hash.new
real_people.each do |person|
   pmap[person[0]] = Person.new(person[1], person[2])
end

pmap['Maggie'].update_profile('Gay', true)
recruits.each do |recruit|
   pmap[recruit[1]].update_profile(recruit[2], recruit[3])
   #print recruit[0]
   pmap[recruit[0]].add_link(pmap[recruit[1]])
   pmap[recruit[1]].add_recruiter(pmap[recruit[0]])
end
pmap['Homer'].reset_who

pmap.each do |key, value|
  print key, value, "\n"
  ResponderMailer.real_tester_email({email_address: "cmh@cs.rit.edu", name: value.name, orientation: value.orientation, who_recruit: value.who_recruit, recruiters: value.recruiters}).deliver
end


