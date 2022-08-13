# python

import face_recognition as fr
import cv2
import numpy as np
import os
from datetime import datetime
import urllib.request


# flutter

import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import firestore
import json

cred = credentials.Certificate("../attendanceapp/lib/python_code/final/key.json")
# initalize firebase
firebase_admin.initialize_app(cred,{'storageBucket':'emailpasswordauth-2b4d2.appspot.com'})
# reading from the database
db = firestore.client()

users = db.collection('users').stream()
user_found = False
current_user_id = ''
userDict={}
userID = {}


def getUserId(users):
     for user in users:
          person = user.to_dict()
          firstName = person.get('firstName')
          secondName = person.get('secondName')
          fullName = firstName + '_' + secondName
          if(user.to_dict()['uid']==user.id):
               current_user_id=user.id
               user_found=True
               coll = db.collection("users").document(current_user_id).collection('images')
               datas = coll.get()
               for data in datas:
                    documentId=data.id
                    downloadUrl = data.to_dict()['downloadUrl']
               userDict[current_user_id] = createDict(current_user_id, documentId, fullName, downloadUrl)
            #    userDict[current_user_id] = downloadImg(current_user_id, documentId, fullName, downloadUrl)
               
          else:
               print('User not found in document ',user.id)



def createDict(current_user_id, documentId, fullname, downloadUrl):
     userID = {}
     userID['document_id'] = documentId
     userID['fullname'] = fullname
     userID['download_url'] = downloadUrl
    #  downloadImg(current_user_id, documentId, fullname, downloadUrl)
     return userID

# machine learning

def downloadImg(userDict):
     for key, value in userDict.items():
             #  print(key, value)
         userID = key
         documentId = value['document_id']
         fullname = value['fullname']
         downloadUrl = value['download_url']
        #  print(userID, documentId, fullname, downloadUrl)
         status_code = urllib.request.urlopen(downloadUrl).getcode()
         if status_code!=200:
              print('Error downloading image')
         else:
              filepath = '../attendanceapp/lib/python_code/final/test/'
              filename = userID+'.jpg'
              fullpath = os.path.join(filepath, filename)
              urllib.request.urlretrieve(downloadUrl, fullpath)     
        
   


getUserId(users)
# print("printing userDict", userDict)
userDictJson = json.dumps(userDict)
# print(userDictJson)
with open('../attendanceapp/lib/python_code/final/userDictJson.json', 'w') as f:
     json.dump(userDict, f)
downloadImg(userDict)

def extractName(userDict):
         for key, value in userDict.items():
                  userID = key
                  fullname = value['fullname']
                  test_image_names.append(userID)
         return test_image_names
     
def attendance(name):
         with open('../attendanceapp/lib/python_code/final/result/attendance.csv', 'a+') as f:
             myDataList = f.readlines()
             nameList = []
             for line in myDataList:
                      entry = line.split(',')
                      nameList.append(entry[0])
             if name not in nameList:
                      time_now = datetime.now()
                      tStr = time_now.strftime('%H:%M:%S')
                      dStr = time_now.strftime('%d/%m/%Y')
                      f.writelines(f'\n{name},{tStr},{dStr}')

path = "../attendanceapp/lib/python_code/final/train/"
test_path = "../attendanceapp/lib/python_code/final/test/"

known_names = []
known_name_encodings = []

test_image_names = []


images = os.listdir(path)
for _ in images:
    image = fr.load_image_file(path + _)
    image_path = path + _
    encoding = fr.face_encodings(image)[0]

    known_name_encodings.append(encoding)
    known_names.append(os.path.splitext(os.path.basename(image_path))[0].upper())

print(known_names)

print(extractName(userDict))

# download_images = os.listdir(test_path)
# print(download_images)
# for _ in download_images:
#          test_image = fr.load_image_file(test_path + _)
#          test_image_path = test_path + _
#          print(test_image_path)
#          encoding_test_image = fr.face_encodings(test_image)[0]
         
#          download_name_encodings.append(encoding_test_image)
#          download_names.append(os.path.splitext(os.path.basename(test_image_path))[0].upper())

# print(download_names)         
for test_name in test_image_names:
        print(test_name)
        extension = '.jpg'
        mypath = test_path + test_name + extension
        test_image = mypath
        print(test_image)
        image = cv2.imread(test_image)
        # image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        face_locations = fr.face_locations(image)
        face_encodings = fr.face_encodings(image, face_locations)

        for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
            matches = fr.compare_faces(known_name_encodings, face_encoding)
            name = ""

            face_distances = fr.face_distance(known_name_encodings, face_encoding)
            best_match = np.argmin(face_distances)

            if matches[best_match]:
                name = known_names[best_match]

            cv2.rectangle(image, (left, top), (right, bottom), (0, 0, 255), 2)
            cv2.rectangle(image, (left, bottom - 15), (right, bottom), (0, 0, 255), cv2.FILLED)
            font = cv2.FONT_HERSHEY_DUPLEX
            cv2.putText(image, name, (left + 6, bottom - 26), font, 1.0, (255, 255, 255), 1)
            attendance(test_name)
            output_img_path = "../attendanceapp/lib/python_code/final/result/" + test_name + ".jpg"
            cv2.imwrite(output_img_path, image)


        # cv2.imshow("Result", image)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
