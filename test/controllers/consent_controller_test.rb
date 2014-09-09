require 'test_helper'

class ConsentControllerTest < ActionController::TestCase
=begin
  test "should get index" do
    get :index
    assert_response :success
   # assert_not_nil assigns(:posts)
  end

  test "basic" do

    out =  Net::HTTP.get(URI(URI.encode("https://graph.facebook.com/179445217929/accounts/test-users?access_token=179445217929|3f881df113dc48cd63b49de1fa1ca39a")))
    outhash = JSON.parse(out)
    get :check, nil, {'recruitee_coupon' => '814', 'facebook_access_token' => outhash['data'][0]['access_token'].to_s, 'facebook_account_number' => outhash['data'][0]['id'].to_i}
   
    out =  Net::HTTP.get(URI(URI.encode("https://graph.facebook.com/" + outhash['data'][0]['id'])))

    print out
    assert_redirected_to :controller => 'surveyor', :action => 'create', :id => session[:facebook_response_id]
   
  end
=end

  test "facebook users" do

    user = Hash.new         
    out =  Net::HTTP.get(URI(URI.encode("https://graph.facebook.com/179445217929/accounts/test-users?access_token=179445217929|3f881df113dc48cd63b49de1fa1ca39a")))
    JSON.parse(out)['data'].each do |u| 
      i = URI.parse("https://graph.facebook.com/" + u['id'])
      r =  Net::HTTP.get(i)
      user[JSON.parse(r)["first_name"]] = u 
      puts JSON.parse(r)["first_name"]
      puts u.to_s
    end

    puts "Adding Homer"
    puts user['Homer']
    session[:facebook_account_number] = "888888888 7 88888888"
    post(:check, {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Bisexual"}}, {'recruitee_coupon' => 814, 'facebook_access_token' => user['Homer']['access_token'], 'facebook_account_number' => "888888888 7 88888888"})
    FacebookResponse.find_each do |x| 
      puts x.orientation
    end
    #puts ConsentController.facebook_user.id 
    puts "Adding Ned"
    post(:check, {"facebook_response"=>{"eighteen_or_older"=>true, "gender"=>"Male", "orientation"=>"Bisexual"}}, {'recruitee_coupon' => 814, 'facebook_access_token' => user['Ned']['access_token'], 'facebook_account_number' => user['Ned']['id']})
    FacebookResponse.find_each do |x| 
      puts x.to_yaml
    end

  end
end
