import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:provider/provider.dart';
import 'package:sankore_app/data/controllers/provider_controller.dart';
import 'package:sankore_app/widgets/app_icon.dart';

import '../helper/custom_loader.dart';
import '../utils/colors.dart';

class SMSPage extends StatefulWidget {
  const SMSPage({Key? key}) : super(key: key);

  @override
  State<SMSPage> createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  List<SmsMessage> smsMessages = [];

  void getSMS() async {
    context.read<ProviderController>().getSmsMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Consumer<ProviderController>(builder: (_, controller, child) {
          getSMS();
          smsMessages = context.read<ProviderController>().smsMessages;
          return !context.read<ProviderController>().isLoading
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: smsMessages.length,
                  itemBuilder: (context, index) {
                    var message = smsMessages[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: AppIcon(
                          icon: Icons.sms,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                        title: Text('${message.sender} [${message.date}]',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '${message.body}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: AppColors.buttonBackgroundColor,
                        contentPadding: const EdgeInsets.all(8),
                        horizontalTitleGap: 8,
                      ),
                    );
                  },
                )
              : const Center(child: CustomLoader());
        }),
      ),
    );
  }
}
