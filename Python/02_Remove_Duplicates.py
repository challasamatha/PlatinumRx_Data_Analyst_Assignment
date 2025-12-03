def remove_duplicates(input_string):
    result = ""           # empty string to store unique characters

    for ch in input_string:
        if ch not in result:    # check if not already added
            result += ch

    return result 
    
s = input()
print(remove_duplicates(s))