import 'package:cloud_firestore/cloud_firestore.dart';

<<<<<<< Updated upstream
DateTime? dateTimeFromTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
=======
DateTime? dateTimeFromTimestamp(Timestamp? timestamp) {
  return timestamp?.toDate();
>>>>>>> Stashed changes
}
