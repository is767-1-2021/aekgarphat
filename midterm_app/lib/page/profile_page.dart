import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String urlImage;

  const ProfilePage({
    Key key,
    this.name,
    this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(name),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Image.network(
          urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}
