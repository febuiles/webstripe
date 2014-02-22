puts "Creating admin..."
unless User.find_by_username("admin")
  user = User.new(email: "admin@webstripe.co", password: "password", username: "admin", name: "Admin")
  user.role = "admin"
  user.save!
end
