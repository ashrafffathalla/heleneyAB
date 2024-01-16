import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../common/widgets/common_fun.dart';
import '../../common/widgets/confirmation_dialog.dart';
import '../../common/widgets/loader.dart';
import '../../common/widgets/snack_bar_widget.dart';
import '../../model/chat_and_live_stream/live_stream.dart';
import '../../model/user/registration_user.dart';
import '../bottom_diamond_shop/bottom_diamond_shop.dart';
import '../explore_screen/widgets/reverse_swipe_dialog.dart';
import '../person_streaming_screen/person_streaming_screen.dart';
import '../random_streming_screen/random_streaming_screen.dart';

class LiveGridScreenViewModel extends BaseViewModel {
  RegistrationUserData? registrationUser;
  String? identity;
  List<LiveStreamUser> userData = [];
  List<String?> userEmail = [];
  bool isLoading = false;
  late FirebaseFirestore db;
  late CollectionReference collection;
  StreamSubscription<QuerySnapshot<LiveStreamUser>>? subscription;
  int? walletCoin;
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  void init() {
    db = FirebaseFirestore.instance;
    getProfileAPi();
    getBannerAd();
    initInterstitialAds();
  }

  void onBackBtnTap() {
    if (interstitialAd == null) {
      Get.back();
    } else {
      interstitialAd?.show().whenComplete(() {
        Get.back();
      });
    }
  }

  void initInterstitialAds() {
    CommonFun.interstitialAd((ad) {
      interstitialAd = ad;
    });
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }

  void goLiveBtnClick() {
    registrationUser?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.dialog(
            ConfirmationDialog(
              onYesBtnClick: onGoLiveTap,
              aspectRatio: 1 / 0.6,
              horizontalPadding: 60,
              onNoBtnClick: onBackBtnTap,
              subDescription: AppRes.doYouReallyWantToLive,
              heading: AppRes.areYouSure,
              clickText2: AppRes.cancel,
              clickText1: AppRes.continueText,
            ),
          );
  }

  Future<void> onGoLiveTap() async {
   Get.back();
    await [Permission.camera, Permission.microphone].request().then((value) {
      print('1111111110');
      if ((value[Permission.camera] == PermissionStatus.granted && value[Permission.microphone] == PermissionStatus.granted) && Platform.isIOS) {
        print('111111111');
        db.collection(FirebaseConst.liveHostList).doc(registrationUser?.identity).set(LiveStreamUser(
                    userId: registrationUser?.id,
                    fullName: registrationUser?.fullname,
                    userImage: registrationUser?.images != null || registrationUser!.images!.isNotEmpty
                        ? registrationUser!.images![0].image
                        : '',
                    agoraToken: '',
                    id: DateTime.now().millisecondsSinceEpoch,
                    collectedDiamond: 0,
                    hostIdentity: registrationUser?.identity,
                    isVerified: false,
                    joinedUser: [],
                    address: registrationUser?.live,
                    age: registrationUser?.age,
                    watchingCount: 0)
                .toJson());
        print('111111112');
        print(value[Permission.microphone].toString() +"GGGG0");
        Get.to(() => const RandomStreamingScreen(), arguments: {
          ConstRes.aChannelId: registrationUser?.identity,
          ConstRes.aIsBroadcasting: true,
        })?.then((value) async {
          print('111111113');
         notifyListeners();
          print('111111114');
        });
      } else if(value[Permission.camera] == PermissionStatus.permanentlyDenied||value[Permission.microphone] == PermissionStatus.permanentlyDenied){
         Permission.camera.request();
         Permission.microphone.request();
         print(value[Permission.camera].toString() +"GGGG2");
      }else {
        print(value[Permission.camera].toString() +"GGGG");
        openAppSettings();
      }
    });
  }

  void getLiveUsers() {
    isLoading = true;
    collection = db.collection(FirebaseConst.liveHostList);
    subscription = collection
        .withConverter(
          fromFirestore: LiveStreamUser.fromFirestore,
          toFirestore: (LiveStreamUser value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .listen((element) {
      userData = [];
      for (int i = 0; i < element.docs.length; i++) {
        userData.add(element.docs[i].data());
      }
      isLoading = false;
      notifyListeners();
    });
  }

  void onLiveStreamProfileTap(LiveStreamUser? user) {
    if (registrationUser?.isBlock == 1) {
      return SnackBarWidget().snackBarWidget(AppRes.userBlock);
    } else {
      if (registrationUser?.isFake != 1) {
        if (ConstRes.liveWatchingPrice <= walletCoin! && walletCoin != 0) {
          Get.dialog(
            ReverseSwipeDialog(
                onCancelTap: onBackBtnTap,
                onContinueTap: (isSelected) {
                  Get.back();
                  showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) {
                      return Center(
                        child: Loader().lottieWidget(),
                      );
                    },
                  );
                  minusCoinApi().then((value) {
                    onImageTap(user);
                  });
                },
                isCheckBoxVisible: false,
                walletCoin: walletCoin,
                title1: AppRes.liveCap,
                title2: AppRes.streamCap,
                dialogDisc: AppRes.liveStreamDisc,
                coinPrice: '${ConstRes.liveWatchingPrice}'),
          );
        } else {
          Get.dialog(
            EmptyWalletDialog(
              onCancelTap: onBackBtnTap,
              onContinueTap: () {
                Get.back();
                Get.bottomSheet(
                  const BottomDiamondShop(),
                );
              },
              walletCoin: walletCoin,
            ),
          );
        }
      } else {
        onImageTap(user);
      }
    }
  }

  Future<void> getProfileAPi() async {
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      registrationUser = value?.data;
      walletCoin = value?.data?.wallet;
      notifyListeners();
    });
    getLiveUsers();
  }

  Future<void> minusCoinApi() async {
    await ApiProvider().minusCoinFromWallet(ConstRes.liveWatchingPrice);
    getProfileAPi();
  }

  void onImageTap(LiveStreamUser? user) {
    userEmail.add(registrationUser?.identity);
    db.collection(FirebaseConst.liveHostList).doc(user?.hostIdentity).update({
      FirebaseConst.watchingCount: user!.watchingCount! + 1,
      FirebaseConst.joinedUser: FieldValue.arrayUnion(userEmail)
    }).then((value) {
      Get.back();
      Get.to(() => const PersonStreamingScreen(), arguments: {
        ConstRes.aChannelId: user.hostIdentity,
        ConstRes.aIsBroadcasting: false,
        ConstRes.aUserInfo: user
      });
    }).then((value) {
      getProfileAPi();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
