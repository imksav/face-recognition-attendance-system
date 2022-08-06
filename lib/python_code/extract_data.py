
import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import firestore
import numpy as np
import cv2
import json
# import sys
# sys.argv[1]

cred = credentials.Certificate("../attendanceapp/lib/python_code/key.json")
# initalize firebase
firebase_admin.initialize_app(cred,{'storageBucket':'emailpasswordauth-2b4d2.appspot.com'})
# reading from the database
db = firestore.client()

users = db.collection('users').stream()
user_found = False
current_user_id = ''
userDict={}

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
               
          else:
               print('User not found in document ',user.id)



def createDict(current_user_id, documentId, fullname, downloadUrl):
     userID = {}
     userID['document_id'] = documentId
     userID['fullname'] = fullname
     userID['download_url'] = downloadUrl
     # sendDataToFirebase(current_user_id, documentId, fullname, downloadUrl)
     return userID

# def sendDataToFirebase(current_user_id, documentId, fullname, downloadUrl):
#      db.collection(u'jsonData').add({'userId': current_user_id, 'documentId': documentId, 'fullname': fullname , 'downloadUrl': downloadUrl})
#      print('Data sent to firebase')

getUserId(users)
userDictJson = json.dumps(userDict)
with open('../attendanceapp/lib/python_code/userDictJson.json', 'w') as f:
     json.dump(userDict, f)




     

