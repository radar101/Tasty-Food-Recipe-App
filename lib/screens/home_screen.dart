import 'package:flutter/material.dart';
import 'package:food_recipe/cards/recipe_card_detail.dart';
import 'package:food_recipe/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackground,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white12
          ),
          child: TextField(
            controller: TextEditingController(),
            textAlign: TextAlign.start,
            autofocus: false,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white12),),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
              alignLabelWithHint: false,
                prefix: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "  Search for recipes",
                hintStyle: TextStyle(color: Colors.grey, ),),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Delicious',
              style: TextStyle(color: Colors.white, fontSize: 15 ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Easy to Cook Menu',
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
