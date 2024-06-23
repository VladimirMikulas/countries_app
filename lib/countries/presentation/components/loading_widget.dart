import 'package:countries_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n=context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
        ),
        Container(
          child: Lottie.asset('assets/loading.json'),
        ),
        Text(l10n.loading,
        style: TextStyle(
          fontSize: 16,
        ),),
      ],
    );
  }
}
