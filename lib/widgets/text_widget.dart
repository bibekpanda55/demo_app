import 'package:demo_app/util/style_util.dart';
import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({required this.text, super.key});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: StyleUtile.titleStyle,
    );
  }
}

class SubtitleTextWidget extends StatelessWidget {
  const SubtitleTextWidget({required this.text, super.key});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "-",
      style: StyleUtile.subtitleStyle,
    );
  }
}

class HeadlineTextWidget extends StatelessWidget {
  const HeadlineTextWidget({required this.text, super.key});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "-",
      style: StyleUtile.headline,
    );
  }
}
