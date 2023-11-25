import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/review_list_view_component.dart';
import 'package:handyman_provider_flutter/components/view_all_label_component.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/booking_detail_response.dart';
import 'package:handyman_provider_flutter/models/service_detail_response.dart';
import 'package:handyman_provider_flutter/models/service_model.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/provider/packages/components/package_component.dart';
import 'package:handyman_provider_flutter/provider/services/components/service_detail_header_component.dart';
import 'package:handyman_provider_flutter/provider/services/components/service_faq_widget.dart';
import 'package:handyman_provider_flutter/provider/services/shimmer/service_detail_shimmer.dart';
import 'package:handyman_provider_flutter/screens/rating_view_all_screen.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceDetailScreen extends StatefulWidget {
  final int serviceId;

  ServiceDetailScreen({required this.serviceId});

  @override
  ServiceDetailScreenState createState() => ServiceDetailScreenState();
}

class ServiceDetailScreenState extends State<ServiceDetailScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(transparentColor, delayInMilliSeconds: 1000);
  }

  Widget serviceFaqWidget({required List<ServiceFaq> data}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          ViewAllLabel(label: languages.lblFAQs, list: data),
          8.height,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: data.length,
            itemBuilder: (_, index) {
              return ServiceFaqWidget(serviceFaq: data[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget customerReviewWidget({required List<RatingData> data, int? serviceId, required ServiceDetailResponse serviceDetailResponse}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        ViewAllLabel(
          label: '${languages.review} (${serviceDetailResponse.serviceDetail!.totalReview})',
          list: data,
          onTap: () {
            RatingViewAllScreen(serviceId: serviceId).launch(context).then((value) => init());
          },
        ),
        8.height,
        data.isNotEmpty
            ? ReviewListViewComponent(
                ratings: data,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 6),
              )
            : Text(languages.lblNoReviewYet, style: secondaryTextStyle()),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget availableWidget({required ServiceData data}) {
    if (data.serviceAddressMapping.validate().isEmpty) return Offstage();

    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(languages.availableAt, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
          16.height,
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              data.serviceAddressMapping!.length,
              (index) {
                ServiceAddressMapping value = data.serviceAddressMapping![index];
                if (value.providerAddressMapping == null) return Offstage();

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: boxDecorationDefault(color: context.cardColor),
                  child: Text(
                    '${value.providerAddressMapping!.address.validate()}',
                    style: boldTextStyle(color: textPrimaryColorGlobal),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget buildBodyWidget(AsyncSnapshot<ServiceDetailResponse> snap) {
    if (snap.hasData) {
      return AnimatedScrollView(
        padding: EdgeInsets.only(bottom: 120),
        listAnimationType: ListAnimationType.FadeIn,
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceDetailHeaderComponent(
            serviceDetail: snap.data!.serviceDetail!,
            voidCallback: () {
              setState(() {});
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(languages.hintDescription, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
              16.height,
              snap.data!.serviceDetail!.description.validate().isNotEmpty
                  ? ReadMoreText(
                      snap.data!.serviceDetail!.description.validate(),
                      style: secondaryTextStyle(),
                      textAlign: TextAlign.justify,
                      colorClickableText: context.primaryColor,
                    )
                  : Text(languages.lblNoDescriptionAvailable, style: secondaryTextStyle()),
            ],
          ).paddingAll(16),
          availableWidget(data: snap.data!.serviceDetail!),
          PackageComponent(servicePackage: snap.data!.serviceDetail!.servicePackage.validate()),
          if (snap.data!.serviceFaq.validate().isNotEmpty) serviceFaqWidget(data: snap.data!.serviceFaq.validate()),
          customerReviewWidget(data: snap.data!.ratingData!, serviceId: snap.data!.serviceDetail!.id, serviceDetailResponse: snap.data!),
          24.height,
        ],
      );
    }

    return snapWidgetHelper(snap, loadingWidget: ServiceDetailShimmer());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ServiceDetailResponse>(
      initialData: listOfCachedData.firstWhere((element) => element?.$1 == widget.serviceId.validate(), orElse: () => null)?.$2,
      future: getServiceDetail({'service_id': widget.serviceId.validate()}),
      builder: (context, snap) {
        return Scaffold(
          body: buildBodyWidget(snap),
        );
      },
    );
  }
}
