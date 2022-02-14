import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizzle/firebase/firebase_configs.dart';
import 'package:quizzle/models/quiz_paper_model.dart';
import 'package:quizzle/utils/logger.dart';

const String folderName = '/assets/DB/papers';

class PapersDataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  uploadData() async {
    loadingStatus.value = LoadingStatus.loading; 
    final fi = FirebaseFirestore.instance;

    try {
      //read asset folder
      final manifestContent = await DefaultAssetBundle.of(Get.context!)
          .loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      //seperate quiz json files
      final papersInAsset = manifestMap.keys
          .where((path) =>
              path.startsWith('assets/DB/papers/') && path.contains('.json'))
          .toList();

      final List<QuizPaperModel> quizPapers = [];

      for (var paper in papersInAsset) {
        //read content of papers(json files)
        String stringPaperContent = await rootBundle.loadString(paper);
        //add data to model
        quizPapers.add(QuizPaperModel.fromString(stringPaperContent));
      }

      //upload data to firebase

      var batch = fi.batch();

      for (var paper in quizPapers) {
        batch.set(quizePaperFR.doc(paper.id), {
          "title": paper.title,
          "image_url": paper.imageUrl,
          "Description": paper.description,
          "time_seconds": paper.timeSeconds,
          "questions_count" : paper.questions == null ? 0 : paper.questions!.length
        }, 
        
        );

        for (var questions in paper.questions!) {
          
          final questionPath = questionsFR(
            paperId: paper.id,
            questionsId: questions.id
          );

          batch.set(questionPath, {
            "question": questions.question,
            "correct_answer": questions.correctAnswer
          });

          for (var answer in questions.answers) {
            batch.set(questionPath.collection('answers').doc(answer.identifier), {"identifier": answer.identifier, "answer": answer.answer});
          }
        }
      }
      await batch.commit();
      loadingStatus.value = LoadingStatus.completed; 
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }
}
