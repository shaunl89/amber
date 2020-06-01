require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save booking without user or room" do
    booking = Booking.new
    assert_not booking.save
  end

  test "should save with start, end, user, room" do
    booking_params = {
      :start => "2020-06-01 11:00:00 UTC",
      :end => "2020-06-01 12:00:00 UTC",
      :room_id => 2,
      :user_id => 1
    }
    @room = Room.create(name: "meeting room")
    @booking = Booking.new(booking_params)
    # binding.pry
    assert @booking.save!
  end
end
