require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run

# Airbnb
# room.rb => Room
# Room.new(address: '123 street')
# user.rb => User
# booking.rb => Booking

# https://www.airbnb.com/rooms
# rooms_controller => list (all)
# ask the DB for all the rooms, then give the rooms to the view
# see all of the roooms

# https://www.airbnb.com/rooms/16773666
# rooms_controller => show (one)
# ask the DB for for the room w/ID 16773666, then give to the view

# https://www.airbnb.com/bookings
# rooms_controller => list (all)
# ask the DB for all the rooms, then give the rooms to the view
# see all of the rooms
