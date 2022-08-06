# machine learning
import cv2
import numpy as np
import face_recognition
import os
from datetime import datetime
import urllib.request
# flutter
import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import firestore
import json

# machine learning
path = '../attendanceapp/lib/python_code/images/'
images = []
personNames = []
myList = os.listdir(path)
print("Dataset:: ", myList)
for cu_img in myList:
    current_Img = cv2.imread(f'{path}/{cu_img}')
    images.append(current_Img)
    personNames.append(os.path.splitext(cu_img)[0])
print("Trimmed Dataset:: ", personNames)


def faceEncodings(images):
    encodeList = []
    for img in images:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodeList.append(encode)
        # print("Encoded List:: ",encodeList)
    return encodeList


def attendance(name):
    with open('../attendanceapp/lib/python_code/attendance.csv', 'a+') as f:
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
            

# flutter


cred = credentials.Certificate("../attendanceapp/lib/python_code/key.json")
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
          fullName = firstName + ' ' + secondName
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
              urllib.request.urlretrieve(downloadUrl, filepath+filename)     
              filepath = '../attendanceapp/lib/python_code/attendance_img/'
              filename = userID+'_'+fullname+'.jpg'
        
   


getUserId(users)
# print("printing userDict", userDict)
userDictJson = json.dumps(userDict)
# print(userDictJson)
with open('../attendanceapp/lib/python_code/userDictJson.json', 'w') as f:
     json.dump(userDict, f)
downloadImg(userDict)





encodeListKnown = faceEncodings(images)
print('All Encodings Complete!!!')



# cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    faces = cv2.resize(frame, (0, 0), None, 0.25, 0.25)
    faces = cv2.cvtColor(faces, cv2.COLOR_BGR2RGB)

    facesCurrentFrame = face_recognition.face_locations(faces)
    encodesCurrentFrame = face_recognition.face_encodings(
        faces, facesCurrentFrame)

    for encodeFace, faceLoc in zip(encodesCurrentFrame, facesCurrentFrame):
        matches = face_recognition.compare_faces(encodeListKnown, encodeFace)
        faceDis = face_recognition.face_distance(encodeListKnown, encodeFace)
        print("Face Dis:: ",faceDis)
        matchIndex = np.argmin(faceDis)

        if matches[matchIndex]:
            name = personNames[matchIndex].upper()
            print(name)
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.rectangle(frame, (x1, y2 - 35), (x2, y2),
                          (0, 255, 0), cv2.FILLED)
            cv2.putText(frame, name, (x1 + 6, y2 - 6),
                        cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
            attendance(name)

    cv2.imshow('Webcam', frame)
    if cv2.waitKey(1) == 13:
        break

cap.release()
cv2.destroyAllWindows()