import 'package:dars_56_home/ui/screens/home_screen.dart';
import 'package:dars_56_home/ui/screens/ordered_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30,),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: ListTile(
              title: Text("Products"),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
          SizedBox(height: 20,),

          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderedScreen()));
            },
            child: ListTile(
              title: Text("Ordered"),
              trailing: Icon(Icons.arrow_right),
            ),
          )
        ],
      ),
    );
  }
}
