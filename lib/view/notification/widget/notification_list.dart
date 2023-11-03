import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/modal/notificaion/notification.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/costumview/data_not_found.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/notification/widget/item_notification.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  int start = 0;
  ScrollController _scrollController = ScrollController();
  List<NotificationData> notificationList = [];
  bool isLoading = true;
  bool hasMoreData = true;

  @override
  void initState() {
    callApiForNotificationList();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          callApiForNotificationList();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? LoaderDialog()
        : notificationList.isEmpty
            ? DataNotFound()
            : ListView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                children: List.generate(notificationList.length,
                    (index) => ItemNotification(notificationList[index])),
              );
  }

  void callApiForNotificationList() {
    if (!hasMoreData) {
      return;
    }
    if (notificationList.isEmpty) {
      isLoading = true;
      setState(() {});
    }
    ApiService()
        .getNotificationList(
            notificationList.length.toString(), ConstRes.count.toString())
        .then(
      (value) {
        isLoading = false;
        notificationList.addAll(value.data ?? []);
        if ((value.data?.length ?? 0) < ConstRes.count) {
          hasMoreData = false;
        }
        setState(() {});
      },
    );
  }
}
