
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/company_page/company_view.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_provider.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_view.dart';
import 'package:tefmasys_mobile/ui/home_page/home_view.dart';
import 'package:tefmasys_mobile/ui/profile_page/profile_view.dart';


class BottomBarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  static final log = Log("Bottom Bar");
  static final loadingWidget = const Center(
    child: CircularProgressIndicator(),
  );

  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    CustomSnackBar customSnackBar;

    List<Widget> tabs = [
      const HomeView(),
      CompanyView(),
      ComplainProvider(),
      ProfileView(),
    ];

    final bar2 = BottomBarWithSheet(
      disableMainActionButton: true,
      sheetChild: Container(),
      mainActionButtonTheme: MainActionButtonTheme(
        size: 40,
        color: const Color(0xFF2B65E3),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      bottomBarTheme: BottomBarTheme(
        mainButtonPosition: MainButtonPosition.Outside,
        selectedItemBackgroundColor: StyledColors.primaryColor,
        backgroundColor: StyledColors.textFieldsPrimaryLight,
        itemIconSize: 20,
        contentPadding: const EdgeInsets.all(2)
      ),
      selectedIndex: selectedIndex,
      onSelectItem: (index) => setState(() => selectedIndex = index),
      items: [
        BottomBarWithSheetItem(
          icon: Icons.home_filled,
          selectedBackgroundColor: StyledColors.primaryColor,
          label: "Home",
        ),
        BottomBarWithSheetItem(
          icon: Icons.sticky_note_2_outlined,
          selectedBackgroundColor: StyledColors.primaryColor,
          label: "Updates",
        ),
        BottomBarWithSheetItem(
          icon: Icons.notifications,
          selectedBackgroundColor: StyledColors.primaryColor,
          label: "Complain",
        ),
        BottomBarWithSheetItem(
          icon: Icons.person,
          selectedBackgroundColor: StyledColors.primaryColor,
          label: "Profile",
        ),
      ],
    );

    final scaffold = Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: bar2,
    );

    return scaffold;
    // return MultiBlocListener(
    //   listeners: [
    //     BlocListener<MainBloc, MainState>(
    //       listenWhen: (pre, current) => pre.error != current.error,
    //       listener: (context, state) {
    //         if (state.error?.isNotEmpty ?? false) {
    //           customSnackBar?.showErrorSnackBar(state.error);
    //         } else {
    //           customSnackBar?.hideAll();
    //         }
    //       },
    //     ),
    //   ],
    //   child: scaffold,
    // );
  }
}
