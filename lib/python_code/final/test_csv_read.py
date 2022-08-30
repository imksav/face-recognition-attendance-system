import csv
from collections import defaultdict
import json

def check_number_of_lines():
     number_of_lines = 0
     for row in open("../attendanceapp/lib/python_code/final/result/attendance.csv"):
          number_of_lines += 1
     return number_of_lines

def iterateAttendanceRecord():
     with open('../attendanceapp/lib/python_code/final/result/attendance.csv', 'r') as file:
          reader = csv.reader(file)
          for row in reader:
               # print(row[0])
               users.append(row[0])
               
def createDict(current_user_id, date, time):
     attendance_record_dict = {}
     # print(current_user_id, date, time)
     # attendance_record_dict[date] += time
     # attendance_record_dict[date] = time
     # attendance_record_dict = dict({date:time})
     # Details[current_user_id][date] = time
     Details[current_user_id].append(date)
     # print(Details)
     # print(userDict)
     return Details


def uniqueUser(current_user_id, number_of_lines):
     with open('../attendanceapp/lib/python_code/final/result/attendance.csv', 'r') as file:
          reader = csv.reader(file)
          for row in reader:
               # print(row[0])
               if(row[0]==current_user_id):
                    time = row[1]
                    date = row[2]
                    userDict[current_user_id] = createDict(current_user_id, date, time)


def checkUniqueUserId(users, number_of_lines):
     user_set = set(users)
     unique_user_list = list(user_set)
     for x in unique_user_list:
          print("Unique Users are::")
          print(x)           
          uniqueUser(x, number_of_lines)


# initalization
users = []
userDict = {}
attendance_record_dict = {}
# Details = defaultdict(dict)
Details = defaultdict(list)


# assignments
number_of_lines = check_number_of_lines()

iterateAttendanceRecord()

checkUniqueUserId(users, number_of_lines)

print("==============================Final Print==============================")
print(Details)
# print(userDict)
print("===========================Convert into Json Format===========================")
userDictJson = json.dumps(Details)
# print(userDictJson)
with open('../attendanceapp/lib/python_code/final/resultDictJson.json', 'w') as f:
     json.dump(Details, f)

