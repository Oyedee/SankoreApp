import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sankore_app/data/controllers/provider_controller.dart';
import 'package:sankore_app/helper/custom_loader.dart';
import 'package:sankore_app/utils/colors.dart';
import 'package:sankore_app/widgets/app_icon.dart';
import 'package:sankore_app/widgets/big_text.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];

  void getContacts() async {
    context.read<ProviderController>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Container(
        child: Consumer<ProviderController>(
          builder: (_, controller, child) {
            getContacts();
            contacts = context.read<ProviderController>().contacts;
            return !context.read<ProviderController>().isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      var contact = contacts[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                          ),
                          title: BigText(
                            text: contact.displayName!,
                            size: 20,
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: AppColors.buttonBackgroundColor,
                        ),
                      );
                    },
                  )
                : const Center(child: CustomLoader());
          },
        ),
      ),
    );
  }
}
