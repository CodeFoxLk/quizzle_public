import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/quiz/result_screen.dart';
import 'package:quizzle/widgets/widgets.dart';

class AnswersCheckScreen extends GetView<QuizController> {
  const AnswersCheckScreen({Key? key}) : super(key: key);

  static const String routeName = '/answercheck';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}', style: kAppBarTS,)),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(Resultcreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                          style: kQuizeTS,
                        ),
                        GetBuilder<QuizController>(
                            id: 'answers_review_list',
                            builder: (context) {
                              return ListView.separated(
                                itemCount: controller
                                    .currentQuestion.value!.answers.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers[index];
                                  final selectedAnswer = controller
                                      .currentQuestion.value!.selectedAnswer;
                                  final correctAnswer = controller
                                      .currentQuestion.value!.correctAnswer;

                                  final String answerText =
                                      '${answer.identifier}. ${answer.answer}';

                                  if (correctAnswer == selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return CorrectAnswerCard(
                                        answer: answerText);
                                  } else if (selectedAnswer == null) {
                                    return NotAnswerCard(answer: answerText);
                                  } else if (correctAnswer != selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return WrongAnswerCard(answer: answerText);
                                  } else if (correctAnswer ==
                                      answer.identifier) {
                                    return CorrectAnswerCard(
                                        answer: answerText);
                                  }

                                  return AnswerCard(
                                    isSelected: false,
                                    onTap: () {},
                                    answer: answerText,
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.screenPadding,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: MainButton(
                          onTap: () {
                            controller.prevQuestion();
                          },
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.nextQuestion();
                          },
                          title: 'Next',
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
