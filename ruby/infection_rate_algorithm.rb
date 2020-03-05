require 'date'

def infection_rate_algorithm(current_rate, date)
  if date.friday?
    current_rate + 1
  else
    current_rate
  end
end