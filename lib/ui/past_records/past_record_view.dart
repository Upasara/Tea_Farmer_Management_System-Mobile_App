import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}

class PastRecordView extends StatelessWidget {


  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Record History",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
          previous.teaCollections != current.teaCollections,
          builder: (context, state) {
            if (state.teaCollections == null) {
              return loadingWidget;
            }

            List<_SalesData> data = [];


            List<Widget> children = [];

            if (state.teaCollections!.isEmpty) {
              children.add(
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 1,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Tea Collections yet',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }


            DateTime currentDate = DateTime.now();
            for (int i = 0; i < 5; i++) {
              DateTime month = DateTime(currentDate.year, currentDate.month - i, 1);
              String monthName = _getMonthName(month.month);
              var total=0;
              for(int j = 0; j < state.teaCollections!.length; j++){
                final post = state.teaCollections![j];

                if(post.createdAt.toDate().month==month.month){
                  total=total+post.teaAmount;
                }

              }
              data.add( _SalesData(monthName, total),);

            }


            for (int i = 0; i < state.teaCollections!.length; i++) {
              final post = state.teaCollections![i];

              DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(
                  post.createdAt.millisecondsSinceEpoch);
              String fdatetime = DateFormat('dd-MM-yyy').format(
                  tsdate); //DateFormat() is from intl package

              final card = Card(
                shape: const RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                margin: const EdgeInsets.all(16),
                elevation: 20,
                color: StyledColors.cardColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: StyledColors.primaryColorDark,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: StyledColors.primaryColorDark,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${post.teaAmount} KG",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: StyledColors.primaryColorDark,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: StyledColors.primaryColorDark,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: StyledColors.primaryColorDark,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Rs. ${post.total}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: StyledColors.primaryColorDark,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: StyledColors.primaryColorDark,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: StyledColors.primaryColorDark,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              fdatetime,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: StyledColors.primaryColorDark,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );

              children.add(card);
            }

            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    enableAxisAnimation: true,
                    margin: EdgeInsets.all(10),
                    backgroundColor: StyledColors.textFieldsPrimaryLight.withOpacity(0.5),

                    // Chart title
                    title: ChartTitle(text: 'Monthly Tea Collections'),
                    // Enable legend
                    legend: Legend(isVisible: false),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                        width: 2.4,
                        color: StyledColors.primaryColor,
                          yAxisName: 'amount',
                          dataSource: data.reversed.toList(),
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: '',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    children: children,
                  ),
                )
              ],
            );
          }),
    );
  }
}
