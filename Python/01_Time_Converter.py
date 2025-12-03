def convert_minutes(total_minutes):
    hours = total_minutes // 60           # integer division
    minutes = total_minutes % 60          # remainder

    return f"{hours} hrs {minutes} minutes" 
    
n = int(input()) 
print(convert_minutes(n))
                    