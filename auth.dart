import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    addUserDetails(email);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  String getCurrentUserKey() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; // This is the user's key (UID) in Firebase
    } else {
      return ""; // If there's no logged-in user, return an empty string or handle accordingly.
    }
  }

  Future<bool> getUserTextLesson(String baseSubject, String subject,
      String subSubject, String lesson) async {
    final userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc(subject.toLowerCase())
        .collection("under_områden")
        .doc(subSubject.toLowerCase())
        .collection("lektioner")
        .doc(lesson.toLowerCase());

    final snapshot = await userRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data.containsKey('complete')) {
        return data['complete'];
      }
    }
    return false;
  }

  Future<int> getUserQuestionLesson(String baseSubject, String subject,
      String subSubject, String lesson) async {
    final userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc(subject.toLowerCase())
        .collection("under_områden")
        .doc(subSubject.toLowerCase())
        .collection("lektioner")
        .doc(lesson.toLowerCase());

    final snapshot = await userRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null &&
          data.containsKey('complete') &&
          data.containsKey('progress')) {
        return data['progress'];
      }
    }
    return 0;
  }

  Future<void> updateUserTextLesson(String baseSubject, String subject,
      String subSubject, String lesson) async {
    // Check if the lesson is already marked as complete
    final userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc(subject.toLowerCase());

    final lessonRef = userRef
        .collection("under_områden")
        .doc(subSubject.toLowerCase())
        .collection("lektioner")
        .doc(lesson.toLowerCase());

    final userSnapshot = await userRef.get();

    if (!(userSnapshot.data() ?? {}).containsKey('complete')) {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final subSubjectDoc = await transaction.get(userRef);
        if (subSubjectDoc.exists) {
          final currentProgress = subSubjectDoc.data()?['progress'] ?? 0;

          final lessonSnapshot = await lessonRef.get();
          final isLessonComplete = lessonSnapshot.data()?['complete'] ?? false;

          if (!isLessonComplete) {
            transaction.update(userRef, {'progress': currentProgress + 1});

            final totalRef = FirebaseFirestore.instance
                .collection("users")
                .doc(getCurrentUserKey())
                .collection(baseSubject.toLowerCase())
                .doc('total');

            transaction.update(totalRef, {'progress': currentProgress + 1});
          }
        }
      });
    }

    await lessonRef.set({
      'complete': true,
    });
  }

  Future<void> updateUserQuestionLesson(String baseSubject, String subject,
      String subSubject, String lesson, int progress, bool complete) async {
    // Check if the lesson is already marked as complete
    final userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc(subject.toLowerCase());

    final lessonRef = userRef
        .collection("under_områden")
        .doc(subSubject.toLowerCase())
        .collection("lektioner")
        .doc(lesson.toLowerCase());

    final userSnapshot = await userRef.get();

    if (complete && !(userSnapshot.data() ?? {}).containsKey('complete')) {
      // The current lesson is not already marked as complete, so increment 'progress'
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final subSubjectDoc = await transaction.get(userRef);
        if (subSubjectDoc.exists) {
          final currentProgress = subSubjectDoc.data()?['progress'] ?? 0;

          final lessonSnapshot = await lessonRef.get();
          final isLessonComplete = lessonSnapshot.data()?['complete'] ?? false;

          if (!isLessonComplete) {
            transaction.update(userRef, {'progress': currentProgress + 1});

            final totalRef = FirebaseFirestore.instance
                .collection("users")
                .doc(getCurrentUserKey())
                .collection(baseSubject.toLowerCase())
                .doc('total');

            await totalRef.update({'progress': FieldValue.increment(1)});
          }
        }
      });
    }

    await lessonRef.set({
      'progress': progress,
      'complete': complete,
    });
  }

  Future<int> getSubjectProgress(String baseSubject, String subject) async {
    final subjectRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc(subject.toLowerCase());

    final subjectSnapshot = await subjectRef.get();
    if (subjectSnapshot.exists) {
      final progress = subjectSnapshot.data()?['progress'] ?? 0;
      return progress;
    } else {
      return 0; // If the subject document does not exist, return 0 progress.
    }
  }

  Future<int> getTotalSubSubjectLessonsCount(
      String baseSubject, String subject) async {
    int count = 0;

    //for loop itterating over all subsubjects
    //under-foor loop itterating rach subsubjects lesson
    //+=1 for each

    for (final doc in (await getSubSubjects(baseSubject, subject)).docs) {
      for (final lesson
          in (await getLessons(baseSubject, subject, doc.id)).docs) {
        count += 1;
      }
    }

    return count;
  }

  Future<int> getTotalLessonsCount(String baseSubject) async {
    int count = 0;

    //for loop itterating over all subjects
    //for loop itterating over all subsubjects
    //under-foor loop itterating rach subsubjects lesson
    //+=1 for each

    for (final subject in (await getSubjects(baseSubject)).docs) {
      for (final subSubject
          in (await getSubSubjects(baseSubject, subject.id)).docs) {
        for (final lesson
            in (await getLessons(baseSubject, subject.id, subSubject.id))
                .docs) {
          count += 1;
        }
      }
    }

    return count;
  }

  Future<int> getToatalProgress(String baseSubject) async {
    final subjectRef = FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserKey())
        .collection(baseSubject.toLowerCase())
        .doc("total");

    final subjectSnapshot = await subjectRef.get();
    if (subjectSnapshot.exists) {
      final progress = subjectSnapshot.data()?['progress'] ?? 0;
      return progress;
    } else {
      return 0; // If the subject document does not exist, return 0 progress.
    }
  }

  Future<void> addUserDetails(String email) async {
    final userRef =
        FirebaseFirestore.instance.collection("users").doc(getCurrentUserKey());

    await userRef.set({
      'email': email,
    });

    // Create or update the "ma" document under the user's collection
    await userRef.collection("matematik").doc("total").set({
      'progress': 0,
    });

    for (final doc in (await getSubjects("matematik")).docs) {
      final id = doc.id;

      await userRef.collection("matematik").doc(id).set({
        'progress': 0,
      });

      for (final underDoc in (await getSubSubjects("matematik", id)).docs) {
        final underId = underDoc.id;

        await userRef
            .collection("matematik/$id/under_områden")
            .doc(underId)
            .set({
          'progress': 0,
        });

        for (final lessonDoc
            in (await getLessons("matematik", id, underId)).docs) {
          final lessonId = lessonDoc.id;

          if (lessonDoc.data()["typ"] == "text") {
            await userRef
                .collection("matematik/$id/under_områden/$underId/lektioner")
                .doc(lessonId)
                .set({'complete': false});
          } else {
            await userRef
                .collection("matematik/$id/under_områden/$underId/lektioner")
                .doc(lessonId)
                .set({'progress': 0, 'complete': false});
          }
        }
      }
    }

    await userRef.collection("fysik").doc("total").set({
      'progress': 0,
    });

    for (final doc in (await getSubjects("fysik")).docs) {
      final id = doc.id;

      await userRef.collection("fysik").doc(id).set({
        'progress': 0,
      });

      for (final underDoc in (await getSubSubjects("fysik", id)).docs) {
        final underId = underDoc.id;

        await userRef.collection("fysik/$id/under_områden").doc(underId).set({
          'progress': 0,
        });

        for (final lessonDoc in (await getLessons("fysik", id, underId)).docs) {
          final lessonId = lessonDoc.id;

          await userRef
              .collection("fysik/$id/under_områden/$underId/lektioner")
              .doc(lessonId)
              .set({
            'progress': 0,
          });
        }
      }
    }

    await userRef.collection("prov").doc("total").set({
      'progress': 0,
    });

    for (final doc in (await getSubjects("prov")).docs) {
      final id = doc.id;

      await userRef.collection("prov").doc(id).set({
        'progress': 0,
      });

      for (final underDoc in (await getSubSubjects("prov", id)).docs) {
        final underId = underDoc.id;

        await userRef.collection("prov/$id/under_områden").doc(underId).set({
          'progress': 0,
        });

        for (final lessonDoc in (await getLessons("prov", id, underId)).docs) {
          final lessonId = lessonDoc.id;

          await userRef
              .collection("prov/$id/under_områden/$underId/lektioner")
              .doc(lessonId)
              .set({
            'progress': 0,
          });
        }
      }
    }
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getSubjects(
  String baseSubject,
) {
  final future = FirebaseFirestore.instance
      .collection("kurser/${baseSubject.toLowerCase()}/områden")
      .get();

  return future;
}

Future<QuerySnapshot<Map<String, dynamic>>> getSubSubjects(
    String baseSubject, String subject) {
  final future = FirebaseFirestore.instance
      .collection(
          "kurser/${baseSubject.toLowerCase()}/områden/${subject.toLowerCase()}/under_områden")
      .get();

  return future;
}

Future<QuerySnapshot<Map<String, dynamic>>> getLessons(
    String baseSubject, String subject, String subSubject) {
  final future = FirebaseFirestore.instance
      .collection(
          "kurser/${baseSubject.toLowerCase()}/områden/${subject.toLowerCase()}/under_områden/${subSubject.toLowerCase()}/lektioner")
      .get();

  return future;
}
