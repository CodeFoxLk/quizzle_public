import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/models/models.dart';
import 'package:quizzle/widgets/widgets.dart';

class RecentQuizCard extends StatelessWidget {
  const RecentQuizCard({Key? key, required this.recentTest}) : super(key: key);

  final RecentTest recentTest;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(_padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: UIParameters.cardBorderRadius,
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: recentTest.paperimage == null
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                          )
                        : SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              recentTest.paperimage!,
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recentTest.papername!,
                        style: cardTitleTs(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            children: [
                              IconWithText(
                                icon: const Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                ),
                                text: Text(recentTest.correctCount!),
                              ),
                              IconWithText(
                                icon: const Icon(
                                  Icons.timer,
                                  color: Colors.orange,
                                ),
                                text: Text(recentTest.time!.toString()),
                              ),
                              IconWithText(
                                icon: const Icon(
                                  Icons.emoji_events_outlined,
                                  color: Colors.purple,
                                ),
                                text: Text(recentTest.points.toString()),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {},
              child: Ink(
                width: double.maxFinite,
                padding: UIParameters.screenPadding / 2,
                child: const Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kOnSurfaceTextColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
