
# cred = credentials.Certificate("./key.json")
# # initalize firebase
# firebase_admin.initialize_app(cred,{'storageBucket':'emailpasswordauth-2b4d2.appspot.com'})
# # reading from the database
# db = firestore.client()

# users = db.collection('users').stream()
# user_found = False
# current_user_id = ''
# userDict={}
# userID = {}


# def getUserId(users):
#      for user in users:
#           person = user.to_dict()
#           firstName = person.get('firstName')
#           secondName = person.get('secondName')
#           fullName = firstName + '_' + secondName
#           if(user.to_dict()['uid']==user.id):
#                current_user_id=user.id
#                user_found=True
#                coll = db.collection("users").document(current_user_id).collection('images')
#                datas = coll.get()
#                for data in datas:
#                     documentId=data.id
#                     downloadUrl = data.to_dict()['downloadUrl']
#                userDict[current_user_id] = createDict(current_user_id, documentId, fullName, downloadUrl)
#             #    userDict[current_user_id] = downloadImg(current_user_id, documentId, fullName, downloadUrl)
               
#           else:
#                print('User not found in document ',user.id)



# def createDict(current_user_id, documentId, fullname, downloadUrl):
#      userID = {}
#      userID['document_id'] = documentId
#      userID['fullname'] = fullname
#      userID['download_url'] = downloadUrl
#     #  downloadImg(current_user_id, documentId, fullname, downloadUrl)
#      return userID

# # machine learning

# def downloadImg(userDict):
#      for key, value in userDict.items():
#              #  print(key, value)
#          userID = key
#          documentId = value['document_id']
#          fullname = value['fullname']
#          downloadUrl = value['download_url']
#         #  print(userID, documentId, fullname, downloadUrl)
#          status_code = urllib.request.urlopen(downloadUrl).getcode()
#          if status_code!=200:
#               print('Error downloading image')
#          else:
#               filepath = './test/'
#               filename = userID+'_'+fullname+'.jpg'
#               fullpath = os.path.join(filepath, filename)
#               urllib.request.urlretrieve(downloadUrl, fullpath)     
        
   


# getUserId(users)
# # print("printing userDict", userDict)
# userDictJson = json.dumps(userDict)
# # print(userDictJson)
# with open('./userDictJson.json', 'w') as f:
#      json.dump(userDict, f)
# downloadImg(userDict)
