class ResponderMailer < ActionMailer::Base
  default from: 'Vincent_Silenzio@URMC.Rochester.edu'

  def thank_you_email (recipients)
    @email_address = recipients[:email_address]
    @invitation_url = recipients[:invitation_url]
    mail(:to => @email_address, :subject => 'Thank you')
  end

  def real_tester_email (recipients)
    @email_address = recipients[:email_address]
    @name = recipients[:name]
    @orientation = recipients[:orientation]
    @who_recruit = recipients[:who_recruit]
    @recruiters = recipients[:recruiters]
    

    mail(:to => @email_address, :subject => "Vince and Chris's website test")
  end

  def reminder_email (recipients)
    @email_address = recipients[:email_address]
    @invitation_url = recipients[:invitation_url]
    mail(:to => @email_address, :subject => "Men's Health Study update")
  end

  def payment_email (recipients)
    @email_address = recipients[:email_address]
    @invitation_url = recipients[:invitation_url]
    mail(:to => @email_address, :subject => "Men's Health Study update")
  end

  def bogus_email (recipients)
    @email_address = recipients[:email_address]
    mail(:to => @email_address, :subject => "Disqualified survey response")
  end
end
