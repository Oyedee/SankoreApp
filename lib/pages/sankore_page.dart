import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sankore_app/data/routes/route.dart';
import 'package:sankore_app/helper/custom_snackbar.dart';
import 'package:sankore_app/utils/colors.dart';
import 'package:sankore_app/widgets/app_button.dart';
import 'package:sankore_app/widgets/small_text.dart';

class SankorePage extends StatefulWidget {
  const SankorePage({Key? key}) : super(key: key);

  @override
  State<SankorePage> createState() => _SankorePageState();
}

class _SankorePageState extends State<SankorePage> {
  //request permission
  Future<void> _askPermissions(String routeName) async {
    if (routeName == Routes.contactsPage) {
      PermissionStatus permissionStatus = await _getContactPermission();
      if (permissionStatus == PermissionStatus.granted) {
        if (routeName != null) {
          Navigator.of(context).pushNamed(routeName);
        }
      } else {
        _handleInvalidPermissions(permissionStatus);
      }
    } else {
      PermissionStatus permissionStatus = await _getSmsPermission();
      if (permissionStatus == PermissionStatus.granted) {
        if (routeName != null) {
          Navigator.of(context).pushNamed(routeName);
        }
      } else {
        _handleInvalidPermissions(permissionStatus);
      }
    }
  }

  //get contact permission
  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  //get sms permission
  Future<PermissionStatus> _getSmsPermission() async {
    PermissionStatus permission = await Permission.sms.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.sms.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      showSnackBar(context, 'Access to contact data denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showSnackBar(context, 'Access to contact data permanently denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'Sankore App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            AppButton(
              buttonText: 'Phone Contacts',
              buttonColor: Colors.lightBlueAccent,
              onPress: () {
                //go to contacts screen
                _askPermissions(Routes.contactsPage);
              },
            ),
            AppButton(
              buttonColor: Colors.blueAccent,
              buttonText: 'SMS Messages',
              onPress: () {
                //go to sms screen
                _askPermissions(Routes.smsPage);
              },
            ),
            AppButton(
              buttonColor: Colors.blueAccent,
              buttonText: 'Test API Call',
              onPress: () {
                //test api call via myjsonplaceholder endpoint
                Navigator.pushNamed(context, Routes.postsPage);
              },
            ),
            const SizedBox(height: 20),
            SmallText(
              text: 'Built with Flutter \u{1F4C7}',
              color: AppColors.mainBlackColor,
            ),
            SmallText(
              text: 'By Hamid',
              color: AppColors.mainBlackColor,
            )
          ],
        ),
      ),
    );
  }
}
