import 'package:flutter/material.dart';
import 'package:insta_wordpress/main.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(link) async {
    final Uri url = Uri.parse(link);
  try {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}

void sendEmail() async {
 

 if (!await launchUrl(Uri.parse("mailto:hosivay@gmail.com?subject=subject&body=New%email"))) {
    throw Exception('Could not launch ');
  } else {
    throw 'Could not launch email client.';
  }
}


Widget profile({required String imageUrl}) {
  return CircleAvatar(
    radius: 54,
    backgroundColor: Colors.grey.shade400,
    child: CircleAvatar(
        radius: 53,
        backgroundColor: Colors.white,
        child:
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(imageUrl))),
  );
}

Widget highlight({required String imageUrl, required String title,required String url}) {
  return InkWell(
    onTap: () {
      openUrl(url);
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 17, 0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 41,
            backgroundColor: Colors.grey.shade400,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 37,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          )
        ],
      ),
    ),
  );
}

Widget postView({
  required String image,
  required String title,
  required String excerpt,
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                removePTags(excerpt),
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buttonDownDetailPage(
    {required BuildContext context,
    required String title,
    required Function() onTap,
    bool? isFollow = false}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
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
