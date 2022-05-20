import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sankore_app/data/controllers/provider_controller.dart';
import 'package:sankore_app/utils/colors.dart';
import 'package:sankore_app/widgets/big_text.dart';

import '../helper/custom_loader.dart';
import '../models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];

  void getPosts() async {
    context.read<ProviderController>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Consumer<ProviderController>(
          builder: (_, controller, child) {
            getPosts();
            posts = context.read<ProviderController>().posts;
            return !context.read<ProviderController>().isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //demo data fetched my myjsonplaceholder
                      var post = posts[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: BigText(text: post.title),
                          subtitle: Text(post.body),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: AppColors.yellowColor,
                        ),
                      );
                    })
                : const Center(child: CustomLoader());
          },
        ),
      ),
    );
  }
}
