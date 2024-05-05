import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';
import 'package:tefmasys_mobile/ui/widgets/common_snack_bar.dart';
import 'package:tefmasys_mobile/util/routes.dart';

class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  static final log = Log("ProfileView");
  static final loadingWidget = const Center(
    child: CircularProgressIndicator(),
  );

  bool isEditable = false;
  final _formKey = GlobalKey<FormState>();
  final _descTextController = TextEditingController();
  final _priceTextController = TextEditingController();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _tpController = TextEditingController();
  final _emergencyTp1Controller = TextEditingController();
  final _emergencyTp2Controller = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

    final imgPicker = ImagePicker();

    final titleStyle = const TextStyle(
      color: StyledColors.primaryColorDark,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    );

    final subtitleStyle = TextStyle(
      color: Colors.black.withOpacity(0.4),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    final separator = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            StyledColors.primaryColorDark.withOpacity(0.1),
            StyledColors.primaryColor.withOpacity(0.3)
          ],
        ),
      ),
    );

    _imgFromCamera() async {
      PickedFile image = await imgPicker.getImage(
          source: ImageSource.camera, imageQuality: 60);
      rootCubit.updateProfileImage(image);
      setState(() {
        isEditable = false;
      });
    }

    _imgFromGallery() async {
      PickedFile image = await imgPicker.getImage(
          source: ImageSource.gallery, imageQuality: 60);
      rootCubit.updateProfileImage(image);
      setState(() {
        isEditable = false;
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: StyledColors.primaryColor,
                      ),
                      title: const Text(
                        'Gallery',
                        style:
                            const TextStyle(color: StyledColors.primaryColor),
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: StyledColors.primaryColor,
                    ),
                    title: const Text(
                      'Camera',
                      style: TextStyle(color: StyledColors.primaryColor),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    final scaffold= Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser,
          builder: (context, state) {
            if (state.currentUser == null) return loadingWidget;

            final user = state.currentUser;

            return ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                // Row(
                //   children: [
                //     const Spacer(),
                //     IconButton(
                //         icon: const Icon(Icons.edit_outlined),
                //         onPressed: () {
                //           setState(() {
                //             isEditable = !isEditable;
                //           });
                //         }),
                //     const SizedBox(
                //       width: 16,
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImage(
                      style: const TextStyle(
                        color: StyledColors.primaryColorDark,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                      radius: 40,
                      firstName: user!.name ?? "D",
                      lastName: " ",
                      image: user.profileImage!.isEmpty ||
                              user.profileImage == null
                          ? null
                          : NetworkImage(user.profileImage ?? ""),
                      backgroundColor:
                          StyledColors.primaryColorDark.withOpacity(0.4),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: StyledColors.primaryColorDark,
                          size: 17,
                        ),
                        onPressed: () {
                          _showPicker(context);
                        }),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "NAME",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                          ),
                          controller: _nameController,
                        )
                      : Text(
                          user.name ?? '',
                          style: subtitleStyle,
                        ),
                ),
                separator,
                ListTile(
                  leading: const Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "EMAIL",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            // suffixIcon:  IconButton(onPressed: (){},icon: Icon(Icons.location_on_outlined),iconSize: 28,)
                          ),
                          controller: _addressController,
                        )
                      : Text(
                          user.email,
                          style: subtitleStyle,
                        ),
                ),
                separator,
                ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "ADDRESS",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            // suffixIcon:  IconButton(onPressed: (){},icon: Icon(Icons.location_on_outlined),iconSize: 28,)
                          ),
                          controller: _addressController,
                        )
                      : Text(
                          user.address ?? 'not provide',
                          style: subtitleStyle,
                        ),
                ),
                separator,
                ListTile(
                  leading: const Icon(
                    Icons.phone,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "TEL",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                          ),
                          controller: _tpController,
                        )
                      : Text(
                          user.tel ?? '',
                          style: subtitleStyle,
                        ),
                ),
                separator,
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "REGISTRATION NUMBER",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            // suffixIcon:  IconButton(onPressed: (){},icon: Icon(Icons.location_on_outlined),iconSize: 28,)
                          ),
                          controller: _addressController,
                        )
                      : Text(
                          user.registerNumber,
                          style: subtitleStyle,
                        ),
                ),
                separator,
                ListTile(
                  leading: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: StyledColors.primaryColorDark,
                  ),
                  minLeadingWidth: 10,
                  title: Text(
                    "COLLECTOR NAME",
                    style: titleStyle,
                  ),
                  subtitle: isEditable
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.2),
                            // suffixIcon:  IconButton(onPressed: (){},icon: Icon(Icons.location_on_outlined),iconSize: 28,)
                          ),
                          controller: _addressController,
                        )
                      : Text(
                          user.name ?? '',
                          style: subtitleStyle,
                        ),
                ),
                separator,
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                  onPressed: () {
                    rootCubit.handleUserLoggedOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.WELCOME_ROUTE, (route) => false);
                  },
                  child: const Text(
                    "LOGOUT",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) => pre.isImageAdding != current.isImageAdding,
          listener: (context, state) {
            if (state.isImageAdding) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),

      ],
      child: scaffold,
    );
  }
}
