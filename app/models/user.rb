class User < ApplicationRecord

  def avatar
    "https://avatars.dicebear.com/api/adventurer/#{ uid }.svg"
  end
end
