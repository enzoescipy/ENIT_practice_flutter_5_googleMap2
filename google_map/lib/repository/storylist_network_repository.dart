import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enitproject/model/storylist_model.dart';
import 'package:enitproject/package/debug_console.dart';
import 'package:enitproject/service/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../const/const.dart';
import 'package:enitproject/model/user_preference_model.dart';

class StoryListNetworkRepository {
  int keyAutoIncrease = 0;

  Future<CollectionReference?> _getUserOwnedStoryListCollection() async {
    final currentUser = AuthService.to.getCurrentUser();
    if (currentUser == null) {
      return Future.value(null);
    }

    final uid = currentUser.uid;
    final collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).where('uid', isEqualTo: uid).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        throw Exception("회원가입은 되었으나, 해당 유저의 UID가 기록된 DB 열이 존재하지 않습니다.");
      } else if (snapshot.docs.length > 1) {
        throw Exception("중복된 UID가 기록된 DB 열이 존재합니다.");
      } else {
        return snapshot.docs[0].reference.collection(COLLECTION_STORYLIST);
      }
    });

    return collectionReference;
  }

  Future<void> createUser(UserPrefModel userModel) async {
    final currentUser = AuthService.to.getCurrentUser();
    if (currentUser == null) {
      return Future.value(null);
    }

    final userCollectionReference = FirebaseFirestore.instance.collection(COLLECTION_USERS);
    final userDocumentReference = userCollectionReference.add({
      KEY_UID: currentUser.uid,
    });

    await userDocumentReference.then((reference) {
      reference.collection(COLLECTION_PRIVATE).add({
        KEY_NICKNAME: userModel.nickname,
        KEY_GROUP: VALUE_BASIC,
      });
    });
  }

  Future<UserPrefModel?> getUserPreference() async {
    final currentUser = AuthService.to.getCurrentUser();
    if (currentUser == null) {
      return Future.value(null);
    }

    // get the non-login-required values from private collection
    final uid = currentUser.uid;
    final nickname =
        await FirebaseFirestore.instance.collection(COLLECTION_USERS).where('uid', isEqualTo: uid).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        throw Exception("회원가입은 되었으나, 해당 유저의 UID가 기록된 DB 열이 존재하지 않습니다.");
      } else if (snapshot.docs.length > 1) {
        throw Exception("중복된 UID가 기록된 DB 열이 존재합니다.");
      } else {
        return snapshot.docs[0].reference.collection(COLLECTION_PRIVATE);
      }
    }).then((collectionReference) {
      return collectionReference.where(KEY_GROUP, isEqualTo: VALUE_BASIC).get().then((snapshot) {
        return snapshot.docs[0].data()[KEY_NICKNAME];
      });
    });

    // get the login-required values from AuthService
    final email = AuthService.to.getEmail();

    debugConsole([email, nickname]);
    return UserPrefModel(email, null, nickname);
  }

  Future<void> updateUserPreference(String nickname) async {
    final currentUser = AuthService.to.getCurrentUser();
    if (currentUser == null) {
      throw Exception("여튼 뭔가 잘못되었습니다.");
    }

    // get the non-login-required values from private collection
    final uid = currentUser.uid;
    await FirebaseFirestore.instance.collection(COLLECTION_USERS).where('uid', isEqualTo: uid).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        throw Exception("회원가입은 되었으나, 해당 유저의 UID가 기록된 DB 열이 존재하지 않습니다.");
      } else if (snapshot.docs.length > 1) {
        throw Exception("중복된 UID가 기록된 DB 열이 존재합니다.");
      } else {
        return snapshot.docs[0].reference.collection(COLLECTION_PRIVATE);
      }
    }).then((collectionReference) {
      collectionReference.where(KEY_GROUP, isEqualTo: VALUE_BASIC).get().then((snapshot) {
        snapshot.docs[0].reference.set({
          KEY_GROUP: VALUE_BASIC,
          KEY_NICKNAME: nickname,
        });
      });
    });
  }

  /// take all of the story from the user's storylist.
  /// if not logined, return null.
  Future<List<StoryListModel>?> getStoryListModel() async {
    final storyListCollRef = await _getUserOwnedStoryListCollection();
    if (storyListCollRef == null) {
      return Future.value(null);
    }

    List<StoryListModel> resultList = [];
    QuerySnapshot querySnapshot = await storyListCollRef.get();
    for (var element in querySnapshot.docs) {
      resultList.add(StoryListModel.fromSnapshot(element));
    }

    // change the keyAutoIncrease to the length of the list
    keyAutoIncrease = resultList.length;

    return resultList;
  }

  /// create story in the user's storylist.
  /// if not logined, return null.
  /// if creation of story succeed, return the DocumentReference.
  Future<DocumentReference<Object?>?> createStoryModel(StoryListModel storyListModel) async {
    final storyListCollRef = await _getUserOwnedStoryListCollection();
    if (storyListCollRef == null) {
      return Future.value(null);
    }

    storyListModel.pkey = keyAutoIncrease;
    keyAutoIncrease++;
    final resultMap = storyListModel.toMap();

    return storyListCollRef.add(resultMap);
  }

  /// delete story from the user's storylist.
  /// if not logined, return false.
  /// if deletion of the story succeed, return true.
  Future<bool> deleteStoryModel(int id) async {
    final storyListCollRef = await _getUserOwnedStoryListCollection();
    if (storyListCollRef == null) {
      return false;
    }

    final futureWorks = storyListCollRef.where('pkey', isEqualTo: id).get().then((value) => value.docs[0].reference.delete());

    await Future.wait([futureWorks]);
    return true;
  }

  /// update the story inside of the user's storylist.
  /// if not logined, return false.
  /// if updation of the story succed, return true.
  Future<bool> updateStoryModel(StoryListModel storyListModel) async {
    final storyListCollRef = await _getUserOwnedStoryListCollection();
    if (storyListCollRef == null) {
      return false;
    }

    final futureWorks = storyListCollRef
        .where('pkey', isEqualTo: storyListModel.pkey)
        .get()
        .then((value) => value.docs[0].reference.set(storyListModel.toMap()));

    await Future.wait([futureWorks]);
    return true;
  }
}

StoryListNetworkRepository storyListNetworkRepository = StoryListNetworkRepository();
