class HolidayDates
  attr_reader :upcoming_dates
  def initialize
    @upcoming_dates = DateService.upcoming_holidays
  end
end