import 'package:cloud_firestore/cloud_firestore.dart';

class RecentTest {
  final String? correctCount;
  final String? paperId;
  String? papername;
  String? paperimage;
  final String? points;
  final int? time;

  RecentTest({
    this.correctCount,
    this.paperId,
    this.papername,
    this.paperimage,
    this.time, 
    this.points,
  });

  RecentTest.fromSnapshot( QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    : correctCount = snapshot['correct_count'] as String?,
      paperId = snapshot['paper_id'] as String?,
      papername = '', //snapshot['papername'] as String?,
      paperimage = '', //snapshot['paperimage'] as String?,
      time = snapshot['time'] as int?,
      points = snapshot['points'] as String?;

  Map<String, dynamic> toJson() => {
    'correct_count' : correctCount,
    'paper_id' : paperId,
    'papername' : papername,
    'paperimage' : paperimage,
    'points' : points
  };
}