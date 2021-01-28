import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paperless_app/i18n.dart';

class AboutRoute extends StatefulWidget {
  @override
  _AboutRouteState createState() {
    return _AboutRouteState();
  }
}

class _AboutRouteState extends State<AboutRoute> {
  List<dynamic> contributors = [];
  List<dynamic> translators = [];

  Future<void> loadContributors() async {
    var _translators = (await Dio()
            .get("https://bauerj.github.io/paperless_app/translators.json"))
        .data["data"];

    var _contributors = (await Dio()
            .get("https://bauerj.github.io/paperless_app/contributors.json"))
        .data;

    setState(() {
      translators = _translators.map((e) => e["data"]["fullName"]).toList();
      contributors = _contributors.map((e) => e["login"]).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadContributors();
  }

  @override
  Widget build(BuildContext context) {
    List<Text> contributorsTexts = contributors.map((e) => Text(e)).toList();
    List<Text> translatorsTexts = translators.map((e) => Text(e)).toList();
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    _Heading(
                      "About".i18n,
                      factor: 2,
                    ),
                    Text(
                      "Paperless App is open-source software licenced under the GNU General Public Licence."
                          .i18n,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Paperless App would not have been possible without the help of some awesome people."
                          .i18n,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _Heading("Code contributors".i18n),
                    Text("The following people have submitted code on Github:"
                        .i18n
                        .i18n),
                    SizedBox(
                      height: 10,
                    ),
                    Column(children: contributorsTexts),
                    SizedBox(
                      height: 20,
                    ),
                    _Heading("Translators".i18n),
                    Text(
                        "Translations for Paperless App were made on Crowdin by:"
                            .i18n),
                    SizedBox(
                      height: 10,
                    ),
                    Column(children: translatorsTexts),
                  ],
                ))));
  }
}

class _Heading extends StatelessWidget {
  final String text;
  final double factor;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textScaleFactor: 2.5 * factor,
        style: TextStyle(fontWeight: FontWeight.bold));
  }

  _Heading(this.text, {this.factor = 1});
}
