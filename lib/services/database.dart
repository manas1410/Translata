import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("name", isEqualTo: username)
        .get();
  }
  getUserByUseremail(String useremail) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: useremail)
        .get();
  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
        .add(userMap);

  }
  createChatRoom(String chatRoomId,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }


  addConversationMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async{
    //print(chatRoomId);
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }
  getChatRooms(String userName) async{
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .where("users",arrayContains: userName)
        .snapshots();

  }


}