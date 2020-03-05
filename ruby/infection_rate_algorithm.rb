require 'date'

MAX_INFECTION_RATE = 100

def infection_rate_algorithm(current_rate, date)
  if date.friday? && current_rate < MAX_INFECTION_RATE
    current_rate + 1
  else
    current_rate
  end
end