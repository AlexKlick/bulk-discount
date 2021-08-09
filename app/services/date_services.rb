class DateServices
  def self.upcoming_holidays
    response = Faraday.get "https://date.nager.at/api/v2/NextPublicHolidays/us"
    body = response.body
    JSON.parse(body, symbolize_names: true)[0..2]
  end
end