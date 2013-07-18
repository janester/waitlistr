class List < ActiveRecord::Base
  has_many :users

  def next_position
    if self.users.length == 0
      return 1
    else
      self.users.order(:position).last.position + 1
    end
  end

  def add_user(user)
    user.position = self.next_position
    user.save
    self.users << user
  end
end