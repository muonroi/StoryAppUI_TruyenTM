// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:muonroi/Items/Static/Buttons/widget.static.button.dart';
// import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.categories.home.dart';
// import 'package:muonroi/Models/Stories/models.stories.story.dart';
// import 'package:muonroi/Pages/Accounts/Logins/pages.logins.sign_in.dart';
// import 'package:muonroi/Settings/settings.colors.dart';
// import 'package:muonroi/Settings/settings.fonts.dart';
// import 'package:muonroi/Settings/settings.images.dart';
// import 'package:muonroi/Settings/settings.language_code.vi..dart';
// import 'package:muonroi/Settings/settings.main.dart';

// class CommentOfStory extends StatefulWidget {
//   final StoryModel widget;
//   const CommentOfStory({super.key, required this.widget});

//   @override
//   State<CommentOfStory> createState() => _CommentOfStoryState();
// }

// class _CommentOfStoryState extends State<CommentOfStory> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GroupCategoryTextInfo(
//           titleText: L(ViCode.voteStoryTextInfo.toString()),
//           nextRoute: const SignInPage(),
//         ),
//         SizedBox(
//           height: MainSetting.getPercentageOfDevice(context, expectHeight: 550)
//               .height,
//           child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.widget.userComments!.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 9.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: MainSetting.getPercentageOfDevice(context,
//                                 expectWidth: 46)
//                             .width,
//                         height: MainSetting.getPercentageOfDevice(context,
//                                 expectHeight: 46)
//                             .height,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                                 widget.widget.userComments?[index].imageLink ??
//                                     ImageDefault.imageAvatarDefault,
//                             progressIndicatorBuilder:
//                                 (context, url, downloadProgress) =>
//                                     CircularProgressIndicator(
//                                         value: downloadProgress.progress),
//                             errorWidget: (context, url, error) =>
//                                 const Icon(
//                     RpgAwesome.book,
//                      size: 56,
//                    ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: MainSetting.getPercentageOfDevice(context,
//                                       expectWidth: 280)
//                                   .width,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 4.0),
//                                         child: Text(
//                                           "${widget.widget.userComments?[index].fullName}",
//                                           style: FontsDefault.h5.copyWith(
//                                               fontWeight: FontWeight.w600),
//                                           textAlign: TextAlign.left,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 1,
//                                         ),
//                                       ),
//                                       Container(
//                                         margin:
//                                             const EdgeInsets.only(bottom: 4.0),
//                                         child: RatingBar.builder(
//                                           itemSize:
//                                               MainSetting.getPercentageOfDevice(
//                                                           context,
//                                                           expectWidth: 15)
//                                                       .width ??
//                                                   25,
//                                           initialRating: 0,
//                                           minRating: 0.5,
//                                           direction: Axis.horizontal,
//                                           allowHalfRating: true,
//                                           itemCount: 5,
//                                           itemPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 2.0),
//                                           itemBuilder: (context, _) =>
//                                               const Icon(
//                                             Icons.star,
//                                             color: Colors.amber,
//                                           ),
//                                           onRatingUpdate: (rating) {},
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon: const Icon(
//                                               Icons.thumb_up_alt_outlined,
//                                               color:
//                                                   ColorDefaults.thirdMainColor,
//                                             )),
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon: const Icon(
//                                               Icons.thumb_down_alt_outlined,
//                                               color:
//                                                   ColorDefaults.thirdMainColor,
//                                             )),
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon:
//                                                 const Icon(Icons.flag_outlined))
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(bottom: 4.0),
//                               width: MainSetting.getPercentageOfDevice(context,
//                                       expectWidth: 290)
//                                   .width,
//                               child: Text(
//                                 '${widget.widget.userComments?[index].voteContent}',
//                                 style: FontsDefault.h5,
//                                 overflow: TextOverflow.fade,
//                                 maxLines: 2,
//                               ),
//                             ),
//                             SizedBox(
//                               child: Text(
//                                 '${widget.widget.userComments?[index].createdDate} ${L(ViCode.passedNumberMinuteTextInfo.toString())}',
//                                 style: FontsDefault.h6.copyWith(
//                                     fontStyle: FontStyle.italic, fontSize: 12),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: SizedBox(
//             child: SizedBox(
//               width:
//                   MainSetting.getPercentageOfDevice(context, expectWidth: 319)
//                       .width,
//               height:
//                   MainSetting.getPercentageOfDevice(context, expectHeight: 40)
//                       .height,
//               child: ButtonWidget.buttonNavigatorNextPreviewLanding(
//                   context, const SignInPage(),
//                   textStyle: FontsDefault.h5.copyWith(
//                       color: ColorDefaults.mainColor,
//                       fontWeight: FontWeight.w600),
//                   color: ColorDefaults.lightAppColor,
//                   borderColor: ColorDefaults.mainColor,
//                   widthBorder: 2,
//                   textDisplay: L(ViCode.writeCommentStoryTextInfo.toString())),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
