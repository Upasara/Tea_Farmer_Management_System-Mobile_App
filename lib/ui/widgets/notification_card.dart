import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/ui/widgets/context_extension.dart';
import 'package:tefmasys_mobile/util/routes.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final Timestamp? createdAt;

  const NotificationCard({
    Key? key,
    required this.title,
    this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        height: context.dynamicHeight(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "$title",
                style: TextStyle(fontSize: 19),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8,),
            SizedBox(
              width: 60,
              child: Text(
                Routes.timeAgoSinceDate(createdAt!.toDate()),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87.withOpacity(0.4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
