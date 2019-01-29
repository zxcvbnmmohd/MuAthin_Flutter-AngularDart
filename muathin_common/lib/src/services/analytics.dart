import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {
  static final FirebaseAnalytics _firebaseAnalytics = new FirebaseAnalytics();
  static final FirebaseAnalyticsObserver _firebaseAnalyticsObserver = new FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  FirebaseAnalytics get firebaseAnalytics => _firebaseAnalytics;
  FirebaseAnalyticsObserver get firebaseAnalyticsObserver => _firebaseAnalyticsObserver;

  // MARK - Analytics

  Future sendDeviceInfo({String userID, Map deviceData}) async {
    await this.firebaseAnalytics.logEvent(name: userID, parameters: deviceData);
  }

  Future sendCurrentUserID({String userID}) async {
    await this.firebaseAnalytics.setUserId(userID);
  }

  Future sendCurrentScreen({String screenName}) async {
    await this.firebaseAnalytics.setCurrentScreen(screenName: screenName);
  }

  // MARK - Observers

  subscribeObserver({RouteAware routeAware, PageRoute route}) {
    this.firebaseAnalyticsObserver.subscribe(routeAware, route);
  }

  unsubscribeObserver({RouteAware routeAware}) {
    this.firebaseAnalyticsObserver.unsubscribe(routeAware);
  }

  notifyAnalyticsOfCurrentScreen(String screenName) {
    this.firebaseAnalyticsObserver.analytics.setCurrentScreen(screenName: screenName);
  }
}
