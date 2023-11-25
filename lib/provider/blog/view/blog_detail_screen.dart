import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/provider/blog/blog_repository.dart';
import 'package:handyman_provider_flutter/provider/blog/component/blog_detail_header_component.dart';
import 'package:handyman_provider_flutter/provider/blog/model/blog_detail_response.dart';
import 'package:handyman_provider_flutter/provider/blog/shimmer/blog_detail_shimmer.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class BlogDetailScreen extends StatefulWidget {
  final int blogId;

  BlogDetailScreen({required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(transparentColor, delayInMilliSeconds: 1000);
  }

  Widget buildBodyWidget(AsyncSnapshot<BlogDetailResponse> snap) {
    if (snap.hasData) {
      return AnimatedScrollView(
        padding: EdgeInsets.only(bottom: 120),
        listAnimationType: ListAnimationType.FadeIn,
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlogDetailHeaderComponent(blogData: snap.data!.blogDetail!),
          16.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(snap.data!.blogDetail!.title.validate(), style: boldTextStyle(size: 20)),
              12.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (snap.data!.blogDetail!.createdAt.validate().isNotEmpty)
                    Row(
                      children: [
                        Text('${languages.published}: ', style: secondaryTextStyle()),
                        Text(snap.data!.blogDetail!.createdAt.validate(), style: primaryTextStyle(size: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ).expand(),
                  if (snap.data!.blogDetail!.totalViews != 0)
                    Row(
                      mainAxisAlignment: snap.data!.blogDetail!.createdAt.validate().isNotEmpty ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Icon(Icons.remove_red_eye, size: 18, color: context.iconColor),
                        8.width,
                        Text('${snap.data!.blogDetail!.totalViews.validate()} ', style: boldTextStyle()),
                        Text(languages.views, style: secondaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ).expand(),
                ],
              ),
              if (snap.data!.blogDetail!.createdAt.validate().isNotEmpty)
                Column(
                  children: [
                    16.height,
                    Row(
                      children: [
                        Text('${languages.published}: ', style: secondaryTextStyle()),
                        Text(snap.data!.blogDetail!.createdAt.validate(), style: primaryTextStyle(size: 12), maxLines: 2, overflow: TextOverflow.ellipsis).expand(),
                      ],
                    ),
                  ],
                ),
              30.height,
              Text(
                snap.data!.blogDetail!.description.validate(),
                style: primaryTextStyle(),
                textAlign: TextAlign.justify,
              ),
              24.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${languages.authorBy}: ', style: secondaryTextStyle()),
                  Text(snap.data!.blogDetail!.authorName.validate(), style: primaryTextStyle(size: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ).center(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      );
    }

    return snapWidgetHelper(snap, loadingWidget: BlogDetailShimmer());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BlogDetailResponse>(
      future: getBlogDetailAPI({AddBlogKey.blogId: widget.blogId.validate()}),
      builder: (context, snap) {
        return Scaffold(
          body: buildBodyWidget(snap),
        );
      },
    );
  }
}
