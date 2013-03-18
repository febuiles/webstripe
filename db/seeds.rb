puts "Creating admin..."
unless User.find_by_username("admin")
  user = User.new(email: "admin@webstripe.co", password: "password", username: "admin")
  user.role = "admin"
  user.save!
end

