months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
week_days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
year = 1900
month = 0
week_day = 1

sun_months = 0

while true
    week_day += month_days[month]
    if year % 4 == 0 and month == 1
        if year % 100 != 0 or year % 400 == 0
            week_day += 1
        end
    end
    week_day %= 7
    month += 1
    if month >= 12
        month = 0
        year += 1
        break if year >= 2001
    end
    if year >= 1901 && week_day == 0
        sun_months += 1
    end
    # puts "1 #{months[month]} #{year} #{week_days[week_day]}"
end

puts sun_months