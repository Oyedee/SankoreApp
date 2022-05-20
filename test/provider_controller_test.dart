import 'package:flutter/cupertino.dart';
import 'package:sankore_app/data/controllers/provider_controller.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProviderController controller;

  setUp(() {
    controller = ProviderController();
  });

  group('ProviderController', () {
    test('getPosts', () {
      controller = ProviderController();
      controller.getPosts();
      expect(controller.posts.length, 0);
    });

    test('getContacts', () {
      controller = ProviderController();
      controller.getContacts();
      expect(controller.contacts.length, 0);
    });

    test('getSMS', () {
      controller = ProviderController();
      controller.getSmsMessages();
      expect(controller.smsMessages.length, 0);
    });
  });
}
