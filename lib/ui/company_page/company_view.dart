import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tefmasys_mobile/db/model/company_update.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';
import 'package:tefmasys_mobile/ui/widgets/notification_card.dart';

import 'update_card.dart';

class CompanyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CompanyViewState();
}

class CompanyViewState extends State<CompanyView> {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    type = 1;
  }

  int type = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Weekly Updates",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
              previous.allUpdates != current.allUpdates,
          builder: (context, state) {
            if (state.allUpdates == null) {
              return loadingWidget;
            }

            int numOfWeeks(int year) {
              DateTime dec28 = DateTime(year, 12, 28);
              int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
              return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
            }

            int weekNumber(DateTime date) {
              int dayOfYear = int.parse(DateFormat("D").format(date));
              int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
              if (woy < 1) {
                woy = numOfWeeks(date.year - 1);
              } else if (woy > numOfWeeks(date.year)) {
                woy = 1;
              }
              return woy;
            }

            int currentWeekNumber = weekNumber(DateTime.now());

            List<Widget> children = [];
            List<Widget> children2 = [];

            final all = List<CompanyUpdate>.of(state.allUpdates ?? []);
            all.sort(
                (user1, user2) => user2.createdAt.compareTo(user1.createdAt));

            if (all.isEmpty) {
              children.add(
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 1,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Any Updates',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            if (all.isEmpty) {
              children2.add(
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 1,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Any Updates',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            if (all.isNotEmpty) {
              for (int i = 0; i < all.length; i++) {
                final col = all[i];

                final weekNo = weekNumber(col.createdAt.toDate());

                if (weekNo == currentWeekNumber) {
                  final card = UpdateCard(
                    type: col.type,
                    content: col.content ?? 'No Content',
                    createdAt: col.createdAt,
                  );

                  children.add(card);
                }
              }
            }
            if (all.isNotEmpty) {
              for (int i = 0; i < all.length; i++) {
                final col = all[i];

                final card = UpdateCard(
                  type: col.type,
                  content: col.content ?? 'No Content',
                  createdAt: col.createdAt,
                );

                children2.add(card);
              }
            }

            return Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 1;
                        });
                      },
                      child: Chip(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        label: const Text(
                          'This Week',
                          style: TextStyle(fontSize: 18),
                        ),
                        backgroundColor: type == 1
                            ? StyledColors.primaryColor
                            : StyledColors.primaryColor.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 2;
                        });
                      },
                      child: Chip(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        label: const Text(
                          'All',
                          style: TextStyle(fontSize: 18),
                        ),
                        backgroundColor: type == 2
                            ? StyledColors.primaryColor
                            : StyledColors.primaryColor.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                    child: ListView(
                  children: type == 1 ? children : children2,
                ))
              ],
            );
          }),
    );
  }
}
