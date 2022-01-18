import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

//遷移方向と遷移先が因数のNavigation
class Nav {
  static Future<dynamic> navigate(
    BuildContext context,
    Widget returnContext,
    Offset beginOffset,
  ) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(pageBuilder: (
        BuildContext? context,
        Animation? animation,
        Animation? secondaryAnimation,
      ) {
        return returnContext;
      }, transitionsBuilder: (
        BuildContext context,
        Animation<double>? animation,
        Animation? secondaryAnimation,
        Widget? child,
      ) {
        return SlideTransition(
          position: Tween(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(animation!),
          child: child,
        );
      }),
    );
  }
}

//LaughTailView用、スクロール
class Scl {
  final Duration startDur = const Duration(milliseconds: 1500);
  final startCur = Curves.fastLinearToSlowEaseIn;
  final Duration sclToBmDur = const Duration(milliseconds: 777);
  final sclToBmCur = Curves.easeInOut;
  final Duration sclToHdDur = const Duration(milliseconds: 2000);
  final sclToHdCur = Curves.easeOutBack;
  final Duration newDur = const Duration(milliseconds: 2222);
  final Duration toRe = const Duration(microseconds: 1);
  final newCur = Curves.easeInOutBack;

  void scrollToBottom(scrollController, duration, curve) {
    var bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      bottomOffset,
      duration: duration,
      curve: curve,
    );
  }

  void scrollToTop(scrollController, duration, curve) {
    final topOffset = scrollController.position.minScrollExtent;
    scrollController.animateTo(
      topOffset,
      duration: duration,
      curve: curve,
    );
  }

  //最新Viewへ移動
  void oneTapTitle(scrollController) {
    scrollToBottom(scrollController, sclToBmDur, sclToBmCur);
  }

  //最古Viewへ移動
  void longTapTitle(scrollController) {
    scrollToTop(scrollController, sclToHdDur, sclToHdCur);
  }

  //新規作成後
  void afterNewPiece(scrollController) {
    scrollToTop(scrollController, toRe, newCur);
    scrollToBottom(scrollController, newDur, newCur);
  }
}

class SetHelper {
  final mailAddress = 'hiroshu.diary@mail.com';
  final urlApp = Platform.isIOS
      ? 'https://apps.apple.com/us/developer/hiroshi-tsunezumi/id1577885245'
      : 'https://play.google.com/store/apps/details?id=com.hiroshu.colorich';

  //URLを後で変える
  void dumpNotify() {
    FlutterLocalNotificationsPlugin().cancelAll();
  }

  Future<void> notify(time) async {
    final flnp = FlutterLocalNotificationsPlugin();

    flnp
        .initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(),
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    )
        .then((_) {
      flnp.showDailyAtTime(
        0,
        'ColoRich',
        '今日を彩ろう',
        Time(time.hour, time.minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            // 'channel_description',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails(),
        ),
      );
    });
  }

  Future<void> _launchURL(openURL) async {
    var url = openURL;
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Unable to launch url $url';
      }
    } else if (Platform.isAndroid) {
      if (await canLaunch(url)) {
        // URLを開く
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isAndroid) {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'smith@example.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Example Subject & Symbols are allowed!'
        }),
      );

      var openURL = emailLaunchUri.toString();

      launch(openURL);
    }
  }

  Future<void> launchMail() async {
    _launchURL('mailto:$mailAddress?subject=&body=');
  }

  Future<void> launchAppStore() async {
    _launchURL(urlApp);
  }
}
