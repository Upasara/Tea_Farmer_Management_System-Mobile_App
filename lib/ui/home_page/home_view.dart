import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tefmasys_mobile/ui/chat_page/chat_view.dart';
import 'package:tefmasys_mobile/ui/past_records/past_record_view.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';
import '../../theme/styled_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

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
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatView(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: StyledColors.primaryColor,
        child: const Icon(Icons.chat),
      ),
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
              previous.teaCollections != current.teaCollections,
          builder: (context, state) {
            if (state.teaCollections == null) {
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

            int total = 0;
            int amount = 0;

            int currentWeekNumber = weekNumber(DateTime.now());
            int weekAmount = 0;
            int weekTotal = 0;

            if (state.teaCollections!.isNotEmpty) {
              for (int i = 0; i < state.teaCollections!.length; i++) {
                final col = state.teaCollections![i];

                final weekNo = weekNumber(col.createdAt.toDate());
                total = total + col.total;
                amount = amount + col.teaAmount;

                if (weekNo == currentWeekNumber) {
                  weekAmount = col.teaAmount;
                  weekTotal = col.total;
                }
              }
            }

            return Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Card(
                  margin: const EdgeInsets.all(16),
                  color: StyledColors.cardColor,
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  shadowColor: Colors.green[100],
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                "To This Day",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Tea Collection",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: StyledColors.primaryColorDark,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$amount KG",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: StyledColors.primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Income",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: StyledColors.primaryColorDark),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Rs. $total",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                StyledColors.primaryColorDark),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(16),
                  color: StyledColors.cardColor,
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  shadowColor: Colors.green[100],
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                "This Week",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Tea Collection",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: StyledColors.primaryColorDark,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$weekAmount KG",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: StyledColors.primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Income",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: StyledColors.primaryColorDark),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Rs. $weekTotal",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                StyledColors.primaryColorDark),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(width: 2, color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PastRecordView(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Record History',
                      style: TextStyle(
                          fontSize: 19, color: StyledColors.primaryColorDark),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
