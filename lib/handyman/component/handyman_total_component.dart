import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/handyman/component/handyman_total_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/handyman_dashboard_response.dart';
import 'package:handyman_provider_flutter/screens/total_earning_screen.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/num_extenstions.dart';
import 'package:handyman_provider_flutter/utils/images.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class HandymanTotalComponent extends StatelessWidget {
  final HandymanDashBoardResponse snap;

  HandymanTotalComponent({required this.snap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        HandymanTotalWidget(
          title: languages.monthlyEarnings,
          total: snap.totalRevenue.validate().toPriceFormat(),
          icon: percent_line,
        ).onTap(
          () {
            TotalEarningScreen().launch(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        HandymanTotalWidget(
          title: languages.lblTotalBooking,
          total: snap.totalBooking.validate().toString(),
          icon: total_services,
        ).onTap(
          () {
            LiveStream().emit(LIVESTREAM_HANDYMAN_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        HandymanTotalWidget(
          title: languages.lblUpcomingServices,
          total: snap.upcomingBookings!.length.validate().toString(),
          icon: total_services,
        ).onTap(
          () {
            LiveStream().emit(LIVESTREAM_HANDY_BOARD, {"index": 1, "type": BookingStatusKeys.accept});
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        HandymanTotalWidget(
          title: languages.lblTodayServices,
          total: snap.todayBooking.validate().toString(),
          icon: total_services,
        ).onTap(
          () {
            LiveStream().emit(LIVESTREAM_HANDYMAN_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ],
    ).paddingAll(16);
  }
}
