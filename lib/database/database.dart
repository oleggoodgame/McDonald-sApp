import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc_donalds/models/profile_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> updateProfile(
    String name,
    String surname,
    Gender gender,
    DateTime? birthday,
  ) async {
    final userId = user?.uid;
    await _db
        .collection("users")
        .doc(userId)
        .collection("profile")
        .doc('profile')
        .update({
          "name": name,
          "surname": surname,
          "gender": gender.toString(),
          "birthday": birthday,
        });
  }

  Future<void> addProfile(
    String userId,
    String name,
    String surname,
    Gender gender,
    bool read,
  ) async {
    await _db
        .collection("users")
        .doc(userId)
        .collection("profile")
        .doc("profile")
        .set({
          "name": name,
          "surname": surname,
          "read": read,
          "gender": gender.toString(),
        });
  }

  Future<void> deleteProfile() async {
    final userId = user?.uid;
    await _db
        .collection("users")
        .doc(userId)
        .collection("profile")
        .doc("profile")
        .delete();
  }

  Future<Profile?> getProfile() async {
    final userId = user?.uid;
    final doc = await _db
        .collection("users")
        .doc(userId)
        .collection("profile")
        .doc("profile")
        .get();

    if (!doc.exists) return null;

    final data = doc.data() as Map<String, dynamic>;
    final Gender gender = data["gender"] == "Gender.nothing"
        ? Gender.nothing
        : (data["gender"] == "Gender.male" ? Gender.male : Gender.female);
    ;
    final String email = user!.email!;
    final DateTime? birthDate = data['birthday'] != null
        ? (data['birthday'] as Timestamp).toDate()
        : null; // або будь-яка дефолтна дата
    print(email);
    print(data["name"]);

    return Profile(
      firstName: data["name"],
      lastName: data['surname'],
      gender: gender,
      birthDate: birthDate,
      email: email,
    );
  }

  Future<void> addDelivery(
    String totalPrice,
    List<Map<String, dynamic>> items,
  ) async {
    final userId = user?.uid;

    await _db.collection("users").doc(userId).collection("yourDelivery").add({
      'items': items,
      'totalPrice': totalPrice,
    });
  }

  Stream<QuerySnapshot> getYourDelivers() {
    final userId = user?.uid;

    return _db
        .collection('users')
        .doc(userId)
        .collection('yourDelivery')
        .snapshots();
  }

  Future<DocumentSnapshot> getYourDeliverOne(String id) {
    final userId = user?.uid;

    return _db
        .collection('users')
        .doc(userId)
        .collection('yourDelivery')
        .doc(id)
        .get();
  }

  Future<void> deleteYourDelivery(String id) async {
    final userId = user?.uid;
    return _db
        .collection('users')
        .doc(userId)
        .collection('yourDelivery')
        .doc(id)
        .delete();
  }
}
