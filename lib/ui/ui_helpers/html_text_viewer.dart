// import 'package:cPocket/utils/view_utils/custom_appbar.dart';
// import 'package:cPocket/utils/view_utils/spacers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
//
// class HtmlTextViewerPage extends StatefulWidget {
//   final String? title;
//   final String? htmlText;
//
//   const HtmlTextViewerPage({Key? key, this.title, this.htmlText}) : super(key: key);
//
//   @override
//   _HtmlTextViewerPageState createState() => _HtmlTextViewerPageState();
// }
//
// class _HtmlTextViewerPageState extends State<HtmlTextViewerPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           children: [
//             VSpacer30(),
//             buildAppBarWithBack(title: widget.title, hideRightIcon: true),
//             Expanded(child: SingleChildScrollView(
//               child: Html(data: widget.htmlText),
//             ))
//           ],
//         ));
//   }
// }
