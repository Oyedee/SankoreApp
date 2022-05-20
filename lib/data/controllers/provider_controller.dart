import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../../models/post.dart';
import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class ProviderController extends ChangeNotifier {
  final SmsQuery _query = SmsQuery();
  List<Contact> _contacts = [];
  List<SmsMessage> _smsMessages = [];
  List<Post> _posts = [];

  List<Contact> get contacts => _contacts;
  List<SmsMessage> get smsMessages => _smsMessages;
  List<Post> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //get phone contacts
  Future<void> getContacts() async {
    if (_contacts.isEmpty) {
      _isLoading = true;
    }
    _contacts = (await ContactsService.getContacts()).toList();
    _isLoading = false;
    notifyListeners();
  }

  //get sms messages
  Future<void> getSmsMessages() async {
    if (_smsMessages.isEmpty) {
      _isLoading = true;
    }
    _smsMessages = await _query.querySms(
      kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
      count: 30,
    );
    _isLoading = false;
    notifyListeners();
  }

  //demonstrate api consumption via http call
  Future<void> getPosts() async {
    if (_posts.isEmpty) {
      _isLoading = true;
    }
    var apiClient = ApiClient(
      '${AppConstants.BASE_URL}${AppConstants.POSTS_URI}',
    );
    _posts = await apiClient.getData();
    _isLoading = false;
    notifyListeners();
    print(_posts);
  }
}
