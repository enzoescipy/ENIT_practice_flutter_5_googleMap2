import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enitproject/model/storylist_model.dart';
import 'package:enitproject/package/debug_console.dart';
import '../const/const.dart';

class StoryListNetworkRepository {
  int keyAutoIncrease = 0;

  // Future<void> copyDepracatedStoryListToNew_debug() async {
  //   final CollectionReference storyListCollRef = FirebaseFirestore.instance.collection(COLLECTION_STORYPLAYLIST_depracated);
  //   // List<StoryListModel> resultList = [];
  //   QuerySnapshot querySnapshot = await storyListCollRef.get();
  //   for (var element in querySnapshot.docs) {
  //     final Map<String, dynamic> storyMap =  StoryListModel.fromSnapshot(element).toMap();
  //     FirebaseFirestore.instance
  //         .collection(COLLECTION_USERS)
  //         .doc('E2GzkrX96YmOWbSSmuJK')
  //         .collection(COLLECTION_STORYLIST)
  //         .add(storyMap);
  //   }
  // }

  Future<void> getStoryListFromTestUser_debug() async {
    final CollectionReference storyListCollRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc('E2GzkrX96YmOWbSSmuJK').collection(COLLECTION_STORYLIST);
    List<StoryListModel> resultList = [];
    QuerySnapshot querySnapshot = await storyListCollRef.get();
    for (var element in querySnapshot.docs) {
      resultList.add(StoryListModel.fromSnapshot(element));
    }

    debugConsole(resultList.map((e) => e.title).toList());
  }

  //전체 스토리 가져오기
  Future<List<StoryListModel>> getStoryListModel() async {
    final CollectionReference storyListCollRef = FirebaseFirestore.instance.collection(COLLECTION_STORYPLAYLIST_depracated);
    List<StoryListModel> resultList = [];
    QuerySnapshot querySnapshot = await storyListCollRef.get();
    for (var element in querySnapshot.docs) {
      resultList.add(StoryListModel.fromSnapshot(element));
    }

    // change the keyAutoIncrease to the length of the list
    keyAutoIncrease = resultList.length;

    return resultList;
  }

  // //선택된 스토리 하나 가져오기
  // Future<List<StoryListModel>> getStoryModel(String storyIDkey) async {
  //   final CollectionReference storyListCollRef = FirebaseFirestore.instance.collection(COLLECTION_STORYPLAYLIST_depracated);
  //   List<StoryListModel> resultList = [];
  //   QuerySnapshot querySnapshot = await storyListCollRef.where(KEY_STORY_PLAY_LIST_KEY, isEqualTo: storyIDkey).get();
  //   for (var element in querySnapshot.docs) {
  //     resultList.add(StoryListModel.fromSnapshot(element));
  //   }
  //   return resultList;
  // }

  Future<DocumentReference<Object?>> createStoryModel(StoryListModel storyListModel) async {
    final CollectionReference storyListCollRef = FirebaseFirestore.instance.collection(COLLECTION_STORYPLAYLIST_depracated);
    storyListModel.pkey = keyAutoIncrease;
    keyAutoIncrease++;
    final resultMap = storyListModel.toMap();

    return storyListCollRef.add(resultMap);
  }

  Future<void> deleteStoryModel(int id) async {
    final futureWorks = FirebaseFirestore.instance
        .collection(COLLECTION_STORYPLAYLIST_depracated)
        .where('pkey', isEqualTo: id)
        .get()
        .then((value) => value.docs[0].reference.delete());

    await Future.wait([futureWorks]);
  }

  Future<void> updateStoryModel(StoryListModel storyListModel) async {
    final futureWorks = FirebaseFirestore.instance
        .collection(COLLECTION_STORYPLAYLIST_depracated)
        .where('pkey', isEqualTo: storyListModel.pkey)
        .get()
        .then((value) => value.docs[0].reference.set(storyListModel.toMap()));

    await Future.wait([futureWorks]);
  }
}

StoryListNetworkRepository storyListNetworkRepository = StoryListNetworkRepository();
