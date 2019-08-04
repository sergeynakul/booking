class Reservation < ApplicationRecord
  belongs_to :table

  validates :user, presence: true
  before_validation :unique_reservation
  before_validation :check_working_hours

  private

  def unique_reservation
    reservations = Reservation.where(table_id: table_id)
    date_ranges = reservations.map { |b| b.start...(b.start + b.duration * 60) }
    check_date = start...(start + duration * 60)

    date_ranges.each do |range|
      errors.add(:base, 'Your reservation overlaps with existing reservation. Please choose a different time.') if range.overlaps? check_date
    end
  end

  def check_working_hours
    restaurant_start_time = table.restaurant.start_time.strftime('%H:%M')
    restaurant_end_time = table.restaurant.end_time.strftime('%H:%M')
    reservation_start_time = start.strftime('%H:%M')
    reservation_end_time = (start + duration * 60).strftime('%H:%M')

    if (reservation_start_time < restaurant_start_time && reservation_start_time > restaurant_end_time) ||
       (reservation_end_time < restaurant_start_time && reservation_end_time > restaurant_end_time)
      errors.add(:base, "The restaurant is open from #{restaurant_start_time} to #{restaurant_end_time}. Make your reservation in this interval.")
    end
  end
end
