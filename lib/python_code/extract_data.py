
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
          print(fullName)
          if(user.to_dict()['uid']==user.id):
               current_user_id=user.id
               user_found=True
               coll = db.collection("users").document(current_user_id).collection('images')
               datas = coll.get()
               for data in datas:
                    documentId=data.id
                    # print(documentId)
                    downloadUrl = data.to_dict()['downloadUrl']
               userDict[current_user_id] = createDict(current_user_id, documentId, fullName, downloadUrl)
               # print(userDict)
               print("==========================================================================================")
               
          else:
               print('User not found in document ',user.id)



def createDict(current_user_id, documentId, fullname, downloadUrl):
     userID = {}
     userID['document_id'] = documentId
     userID['fullname'] = fullname
     userID['download_url'] = downloadUrl
     return userID


getUserId(users)
print("-------------------------------------------------------------------------------------------------------")
userDictJson = json.dumps(userDict)
with open('userDictJson.json', 'a') as f:
     json.dump(userDict, f)

# for user in users:
#      # print(f"{user.id}: {user.to_dict()}")
#      person = user.to_dict()
#      firstName = person.get('firstName')
#      secondName = person.get('secondName')
#      # print(firstName+secondName)
#      print("==========================")
#      if(user.to_dict()['uid']==user.id):
#           current_user_id=user.id
#           user_found=True
#           print('User found in document ',current_user_id)
#      doc_ref = db.collection('users').document(current_user_id).collection('images').stream()
#      print("*********************************")
#      coll = db.collection("users").document(current_user_id).collection('images')
#      datas = coll.get()
#      for data in datas:
#           url = data.to_dict()['downloadUrl']
#           print('downloadUrl', url)
     # document = doc_ref.get()
     # print(document.to_dict())
     # d = doc_ref.get().to_dict()['images']
     # print(d)
     
     
     
     
     
#  stg = firestore.storage(user.id);

     

