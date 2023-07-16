// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:insta_wordpress/data.dart';
import 'package:insta_wordpress/widgets.dart';
import 'package:wordpress_api/wordpress_api.dart';
import 'package:html/parser.dart';

void main() {
  runApp(const MyApp());
}
 
// Remove <p> in description posts
// حذف <p> در کپشن پست ها
String removePTags(String htmlText) {
  final unescape = HtmlUnescape();
  final textWithoutPTags =
      htmlText.replaceAll('<p>', '').replaceAll('</p>', '');

  return unescape.convert(textWithoutPTags);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // empty postdata and image posts :
  List<Post> posts = [];
  List<String> imageUrls = [];

// Get information from WordPress site
// دریافت اطلاعات از سایت وردپرسی
  Future<void> fetchData() async {
    final api = WordPressAPI(wordpressSiteUrl);
    final res = await api.posts.fetch();

    //
    setState(() {
      posts = res.data.cast<Post>();
      imageUrls = extractImageUrls(posts);
    });
  }

  List<String> extractImageUrls(List<Post> posts) {
    final List<String> urls = [];

    for (final post in posts) {
      final document = parse(post.content);
      final imgElements = document.getElementsByTagName('img');

      for (final imgElement in imgElements) {
        final url = imgElement.attributes['src'];
        urls.add(url!);
      }
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    //call fetchData() and Get information from WordPress site
    //صدا کردن و دریافت اطلاعات سایت
    fetchData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: Scaffold(
        appBar: AppBar(
          // username user
          // یوزرنیم کاربر که در اپ بار نمایش داده میشود
          title: const Text(
            userName,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.ellipsis_vertical))
          ],
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // My Profile in Page
                    //پروفایل
                    profile(imageUrl: profileUrl),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // info Page
                        // اطلاعات پیج (مانند تعداد فالور و فالویینگ در اینستاگرام)
                        detail_INFO(title: "Posts", number: posts.length),
                        detail_INFO(title: "Age", number: age),
                        detail_INFO(title: "Version", number: ver),
                      ],
                    )
                  ],
                ),
              ),
              const Column(
                children: [
                  // Name user
                  // نام کاربر
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 4, 0, 2),
                    child: Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  // bio user
                  //بیوگرافی پیج
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 2, 0, 4),
                    child: Row(
                      children: [
                        Text(
                         bio,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  // link user
                  // لینک پیج
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 2, 0, 4),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Icon(Icons.link),
                        ),
                        Text(
                         link,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Row |Follow| |Github| |Email|
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonDownDetailPage(
                        title: "Follow", context: context, isFollow: true),
                    buttonDownDetailPage(title: "Github", context: context),
                    buttonDownDetailPage(title: "Email", context: context),
                  ],
                ),
              ),
              // highlight Page
              // هایلایت پیج
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                child: Row(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          highlight(
                              title: "Github",
                              imageUrl:
                                  githubImage),
                          highlight(
                              title: "Telegram",
                              imageUrl:
                                  telegramImage),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Posts received from the site:
              // پست های دریافتی از سایت:
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 30,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final imageUrl = imageUrls[index];

                    return postView(
                      image: imageUrl,
                      excerpt: post.excerpt!,
                      title: post.title!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buttonDownDetailPage(
      {required BuildContext context,
      required String title,
      bool? isFollow = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.3,
      height: 35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Container(
          color: isFollow! ? Colors.blue : Colors.grey.shade200,
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: isFollow ? Colors.white : Colors.grey.shade900,
            ),
          )),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget detail_INFO({required num number, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "$number",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
