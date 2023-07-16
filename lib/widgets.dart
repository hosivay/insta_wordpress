



import 'package:flutter/material.dart';
import 'package:insta_wordpress/main.dart';

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

Widget highlight({required String imageUrl, required String title}) {
  return Padding(
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
