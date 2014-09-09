require 'test_helper'

class FacebookLoginsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "facebook users" do
    
    recruits = [['Homer','Ned', 'Gay', true],['Homer','Bart', 'Bisexual', true],['Homer','Lenny', 'Bisexual', true],
                ['Homer','Skinner', 'Gay', false], # should not save; too many recruits
                ['Bart','Milhaus', 'Gay', true],
                ['Bart','Fry', 'Bisexual', true],
                ['Bart','Skinner', 'Bisexual', true], # should save now, even though Skinner was rejected before
                ['Bart','Lisa','Bisexual',false], # should not save; too many recruits
                ['Skinner','Milhaus', 'Gay', false], # should not save; Milhaus already recruited
                ['Skinner','Otto', 'Bisexual', false], # with test limit of 16 this should reject

                ['Otto', 'Bart', 'Gay', false],  # should not save; Bart already recruited
                ['Maggie', 'Grandpa', 'Heterosexual', true],
                ['Maggie','Homer', 'Bisexual', false],
                ['Maggie', 'Troy', 'Bisexual', false],
                ['Grandpa','Marge', 'Heterosexual', true],
                ['Grandpa', 'Lisa', 'Bisexual', false],
                ['Grandpa','Burns', 'Heterosexual', true],
                ['Marge','Selma', 'Heterosexual', true],
                ['Marge','Patty', 'Heterosexual', true],
                ['Patty','Zoidberg', 'Heterosexual', false]] # with test limit of 16 this should reject
                

    user = Hash.new         
    out =  Net::HTTP.get(URI(URI.encode("https://graph.facebook.com/179445217929/accounts/test-users?access_token=179445217929|3f881df113dc48cd63b49de1fa1ca39a")))
    JSON.parse(out)['data'].each do |u| 
      i = URI.parse("https://graph.facebook.com/" + u['id'])
      r =  Net::HTTP.get(i)
      user[JSON.parse(r)["first_name"]] = u 
      puts "Adding " + JSON.parse(r)["first_name"]
    end

    ['Rod', 'Scooter', 'Clinton', 'Wiener', 'Nixon', 'Daschle', 'Christie', 'Spitzer', 'Haldeman'].each do |n| 
      puts  n + " is joining"
      #puts user[n]
      open_session do |sess|
        #sess.session[:recruitee_coupon] = 814
        sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Gay"}, 'recruitee_coupon' => "585", 'facebook_access_token' => user[n]['access_token'], 'facebook_account_number' => user[n]['id']})
      end
    end

    ["Sly", "Rose", "Freddy", "Cynthia", "Jerry", "Larry", "Greg", "Paul", "Art"].each do |n| 
      puts  n + " is joining"
      #puts user[n]
      open_session do |sess|
        #sess.session[:recruitee_coupon] = 814
        sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Heterosexual"}, 'recruitee_coupon' => "585", 'facebook_access_token' => user[n]['access_token'], 'facebook_account_number' => user[n]['id']})
      end
    end

    #puts FacebookResponse.all.count
    puts "Homer is joining"
    open_session do |sess|
      sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Bisexual"}, 'facebook_account_number' => user['Homer']['id'], 'recruitee_coupon' => "585", 'facebook_access_token' => user['Homer']['access_token']})
    end
   
    puts "Ned is joining"
    open_session do |sess|
      sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Bisexual"}, 'recruitee_coupon' => 585, 'facebook_access_token' => user['Ned']['access_token'], 'facebook_account_number' => user['Ned']['id']})
      assert_equal sess.redirect?, false
    end    

    puts "Maggie is joining"
    open_session do |sess|
      sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Heterosexual"}, 'facebook_account_number' => user['Maggie']['id'], 'recruitee_coupon' => "585", 'facebook_access_token' => user['Maggie']['access_token']})
    end
   
    puts "Patty is joining"
    open_session do |sess|
      sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Heterosexual"}, 'recruitee_coupon' => 585, 'facebook_access_token' => user['Patty']['access_token'], 'facebook_account_number' => user['Patty']['id']})
      assert_equal sess.redirect?, false
    end    

    recruits.each do |er, ee, orientation, should_redirect| 
      #puts user[er]['id']
      u = FacebookUser.find_by(facebook_account_number: user[er]['id'])
      r = FacebookResponse.find_by(facebook_user_id: u.id)
      puts er + " -> " + ee 
    #  puts er + " (" + r[:recruiter_coupon] + ") -> " + ee + " (" + user[ee]['id'] + ")"
      #puts r.to_s
      puts FacebookResponse.all.count
      open_session do |sess|
        sess.post("/consent/int_check/", {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", 
                      "orientation"=>orientation}, 'recruitee_coupon' => r[:recruiter_coupon], 
                    'facebook_access_token' => user[ee]['access_token'], 'facebook_account_number' => user[ee]['id']})
        puts sess.redirect?
        assert_equal sess.redirect?, should_redirect
        #assert sess.redirect?
      end 
    end
 
  end
end
