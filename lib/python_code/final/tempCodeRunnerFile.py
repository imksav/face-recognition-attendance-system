          for row in reader:
               number_of_lines += 1
               print(row[number_of_lines])
               print(number_of_lines)
               if(row[number_of_lines]==current_user_id):
                    date = row[1]
                    time = row[2]
                    userDict[current_user_id] = createDict(current_user_id, date, time)