class Front < ActiveRecord::Base
before_create :randomize_id


private
def randomize_id
  begin
    self.id = SecureRandom.random_number(1_000_000)
  end while Front.where(id: self.id).exists?
end
end
