def return_number(a)
  ((a / 2)**2) * (65 - (a / 2))
end

def estimate_child_retirement(your_age)
  child_age = your_age / 2
  years_left = 65 - child_age
  child_curr_bank = child_age ** 2
  
  retirement = child_curr_bank * years_left

  retirement
end

p child_retirement(30)
p child_retirement(50)
