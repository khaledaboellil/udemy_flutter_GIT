import 'package:flutter/material.dart';

class SocialSearch extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
      ),
      body: Text('Search'),
    );
  }
}