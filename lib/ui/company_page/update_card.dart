import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/util/db_util.dart';
import 'package:tefmasys_mobile/util/routes.dart';
import 'package:tefmasys_mobile/util/size_config.dart';

class UpdateCard extends StatelessWidget {
  final int type;
  final String content;
  final Timestamp createdAt;

  const UpdateCard({
    Key? key,
    required this.type,
    required this.content,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Card(
        elevation: 0.4,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: type == 1
                  ? Image.asset('assets/images/financial-profit.png',
                      height: 92)
                  : type == 2
                      ? Image.asset('assets/images/shipment.png', height: 92)
                      : type == 3
                          ? Image.asset('assets/images/information.png',
                              height: 92)
                          : type == 4
                              ? Image.asset('assets/images/fertilizer.png',
                                  height: 92)
                              : Image.asset('assets/images/layers.png',
                                  height: 92),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type == 1
                        ? 'Tea Collecting Price'
                        : type == 2
                            ? 'Truck Drivers'
                            : type == 3
                                ? 'Factory Visiting Hours'
                                : type == 4
                                    ? 'Tea Fertilizers'
                                    : 'Other Updates',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: StyledColors.primaryColorDark,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    Routes.timeAgoSinceDate(createdAt.toDate()),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
