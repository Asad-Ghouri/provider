import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:handyman_provider_flutter/auth/sign_in_screen.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/networks/network_utils.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

Future<UserData> loginCurrentUsers(BuildContext context, {required Map<String, dynamic> req}) async {
  try {
    appStore.setLoading(true);

    final userValue = await loginUser(req);
    log("***************** Normal Login Succeeds*****************");

    return userValue.data!;
  } catch (e) {
    throw e.toString();
  }
}

void saveDataToPreference(BuildContext context, {required UserData userData, required Function onRedirectionClick}) async {
  if (userData.status == 1) {
    saveUserData(userData);

    onRedirectionClick.call();
    registerInFirebase(context, userData: userData);
  } else {
    toast(languages.pleaseContactYourAdmin);
    push(SignInScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
  }
}

void registerInFirebase(BuildContext context, {required UserData userData}) async {
  await firebaseLogin(context, data: userData).then((value) async {
    log("Hurray Firebase login successful");
    appStore.setUId(value.validate());
  }).catchError((e) async {
    log("================== Error In Firebase =========================");
  });
}

Future<String> firebaseLogin(BuildContext context, {required UserData data}) async {
  try {
    final firebaseEmail = data.email.validate();
    final firebaseUid = await authService.signInWithEmailPassword(email: firebaseEmail);

    log("***************** User Already Registered in Firebase*****************");

    if (await userService.isUserExistWithUid(firebaseUid)) {
      return firebaseUid;
    } else {
      data.uid = firebaseUid;
      return await authService.setRegisterData(userData: data).catchError((ee) {
        throw "Cannot Register";
      });
    }
  } catch (e) {
    log("======= $e");
    if (e.toString() == USER_NOT_FOUND) {
      log("***************** ($e) User Not Found, Again registering the current user *****************");

      return await registerUserInFirebase(context, user: data);
    } else {
      throw e.toString();
    }
  }
}

Future<String> registerUserInFirebase(BuildContext context, {required UserData user}) async {
  try {
    log("*************************************************** Login user is registering again.  ***************************************************");
    return authService.signUpWithEmailPassword(context, userData: user);
  } catch (e) {
    throw e.toString();
  }
}

Future<void> updatePlayerId({required String playerId}) async {
  if (playerId.isEmpty || !appStore.isLoggedIn) return;

  userService.updatePlayerIdInFirebase(email: appStore.userEmail.validate(), playerId: playerId);

  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
  Map<String, dynamic> req = {
    UserKeys.id: appStore.userId,
    UserKeys.playerId: playerId,
  };

  multiPartRequest.fields.addAll(await getMultipartFields(val: req));

  multiPartRequest.headers.addAll(buildHeaderTokens());

  log("MultiPart Request : ${jsonEncode(multiPartRequest.fields)} ${multiPartRequest.files.map((e) => e.field + ": " + e.filename.validate())}");

  await sendMultiPartRequest(multiPartRequest, onSuccess: (temp) async {
    appStore.setLoading(false);

    if ((temp as String).isJson()) {
      appStore.setPlayerId(playerId);
    }
  }, onError: (error) {
    log(error);
    appStore.setLoading(false);
  }).catchError((e) {
    appStore.setLoading(false);
    log(e);
  });
}

Future<void> setUserInFirebaseIfNotRegistered(BuildContext context) async {
  appStore.setLoading(true);

  UserData tempUserData = UserData()
    ..contactNumber = appStore.userContactNumber.validate()
    ..email = appStore.userEmail.validate()
    ..firstName = appStore.userFirstName.validate()
    ..lastName = appStore.userLastName.validate()
    ..profileImage = appStore.userProfileImage.validate()
    ..userType = appStore.userType.validate()
    ..playerId = getStringAsync(PLAYERID)
    ..username = appStore.userName;

  await registerUserInFirebase(context, user: tempUserData).then((value) {
    appStore.setUId(value);
  }).catchError((e) {
    log(e.toString());
  });

  appStore.setLoading(false);
}
