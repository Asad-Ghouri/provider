
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:handyman_provider_flutter/utils/extensions/string_extension.dart';
import 'package:nb_utils/nb_utils.dart';

import '../auth/change_password_screen.dart';
import '../auth/edit_profile_screen.dart';
import '../auth/sign_in_screen.dart';
import '../components/back_widget.dart';
import '../components/cached_image_widget.dart';
import '../handyman/component/handyman_comission_component.dart';
import '../main.dart';
import '../models/dashboard_response.dart';
import '../networks/rest_apis.dart';
import '../provider/components/commission_component.dart';
import '../provider/wallet/wallet_history_screen.dart';
import '../screens/languages_screen.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import '../utils/configs.dart';
import '../utils/constant.dart';
import '../utils/images.dart';

class CityManagerProfile extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return CityManagerProfileState();
  }

}

class CityManagerProfileState extends State<CityManagerProfile>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.height,
                  //if (appStore.userProfileImage.isNotEmpty)
                  Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: boxDecorationDefault(
                            border: Border.all(color: primaryColor, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: boxDecorationDefault(
                              border: Border.all(color: context.scaffoldBackgroundColor, width: 4),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/ic_fill_profile.png', // Replace this with the path to your image in the asset folder
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 8,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6),
                            decoration: boxDecorationDefault(
                              shape: BoxShape.circle,
                              color: primaryColor,
                              border: Border.all(color: context.cardColor, width: 2),
                            ),
                            child: Icon(AntDesign.edit, color: white, size: 18),
                          ).onTap(() {
                            EditProfileScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                          }),
                        ),
                      ],
                  ),
                  16.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Demo City Manager",
                        style: boldTextStyle(color: primaryColor, size: 16),
                      ),
                      4.height,
                      Text("demo@citymanager.com", style: secondaryTextStyle()),
                    ],
                  ),  // Name and title
                ],
              ).center(),
                if (appStore.earningTypeSubscription && appStore.isPlanSubscribe)
                Column(
                  children: [
                    32.height,
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        backgroundColor: appStore.isDarkMode ? cardDarkColor : primaryColor.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(languages.lblCurrentPlan, style: secondaryTextStyle(color: appStore.isDarkMode ? white : appTextSecondaryColor)),
                              Text(languages.lblValidTill, style: secondaryTextStyle(color: appStore.isDarkMode ? white : appTextSecondaryColor)),
                            ],
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appStore.planTitle.validate().capitalizeFirstLetter(), style: boldTextStyle()),
                              Text(
                                formatDate(appStore.planEndDate.validate(), format: DATE_FORMAT_2),
                                style: boldTextStyle(color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              16.height,
              if (getStringAsync(DASHBOARD_COMMISSION).validate().isNotEmpty) ...[
                CommissionComponent(
                  commission: Commission.fromJson(jsonDecode(getStringAsync(DASHBOARD_COMMISSION))),
                ),
                16.height,
              ],
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
                  backgroundColor: appStore.isDarkMode ? cardDarkColor : cardColor,
                ),
                child: Column(
                  children: [
                    16.height,
                    if (appStore.earningTypeCommission)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0, color: context.dividerColor),
                          SettingItemWidget(
                            leading: Image.asset(ic_un_fill_wallet, height: 16, width: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                            title: languages.lblWalletHistory,
                            trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                            onTap: () {
                              WalletHistoryScreen().launch(context);
                            },
                          ),
                        ],
                      ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0, color: context.dividerColor),
                    SettingItemWidget(
                      leading: Image.asset(language, height: 14, width: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: languages.language,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        LanguagesScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0, color: context.dividerColor),
                    SettingItemWidget(
                      leading: Image.asset(changePassword, height: 18, width: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: languages.changePassword,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        ChangePasswordScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0, color: context.dividerColor),
                    SettingItemWidget(
                      leading: Image.asset(ic_check_update, height: 16, width: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: languages.lblOptionalUpdateNotify,
                      trailing: Transform.scale(
                        scale: 0.7,
                        child: Switch.adaptive(
                          value: getBoolAsync(UPDATE_NOTIFY, defaultValue: true),
                          onChanged: (v) {
                            setValue(UPDATE_NOTIFY, v);
                            setState(() {});
                          },
                        ).withHeight(24),
                      ),
                    ),
                    8.height,
                  ],
                ),
              ),
              SettingSection(
                title: Text(languages.lblDangerZone.toUpperCase(), style: boldTextStyle(color: redColor)),
                headingDecoration: BoxDecoration(color: redColor.withOpacity(0.08)),
                divider: Offstage(),
                items: [
                  8.height,
                  SettingItemWidget(
                    leading: ic_delete_account.iconImage(size: 20, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                    paddingBeforeTrailing: 4,
                    title: languages.lblDeleteAccount,
                    onTap: () {
                      showConfirmDialogCustom(
                        context,
                        negativeText: languages.lblCancel,
                        positiveText: languages.lblDelete,
                        onAccept: (_) {
                          ifNotTester(context, () {
                            appStore.setLoading(true);

                            deleteAccountCompletely().then((value) async {
                              appStore.setLoading(true);

                              await userService.removeDocument(appStore.uid);
                              await userService.deleteUser();
                              await clearPreferences();

                              toast(value.message);

                              appStore.setLoading(false);

                              push(SignInScreen(), isNewTask: true);
                            }).catchError((e) {
                              appStore.setLoading(false);
                              toast(e.toString());
                            });
                          });
                        },
                        dialogType: DialogType.DELETE,
                        title: languages.lblDeleteAccountConformation,
                      );
                    },
                  ).paddingOnly(left: 4),
                ],
              ),
              16.height,
              TextButton(
                child: Text(languages.logout, style: boldTextStyle(color: primaryColor, size: 16)),
                onPressed: () {
                  appStore.setLoading(false);
                  logout(context);
                },
              ).center(),
              VersionInfoWidget(prefixText: 'v', textStyle: secondaryTextStyle()).center(),
              16.height,
            ],
          );
        },
      ),
    );
  }

}