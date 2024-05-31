import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class dataget extends GetxController{

  RxList<dynamic> aa = [].obs;


}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}



class _homepageState extends State<homepage> {
  var controller  = Get.put(dataget());

  List<dynamic> employees = [
    {"name": "John Doe", "experience": 5, "active": true},
    {"name": "Jane Smith", "experience": 8, "active": false},
    {"name": "Alice Johnson", "experience": 3, "active": true},
    {"name": "Bob Brown", "experience": 10, "active": true},
    {"name": "Charlie Davis", "experience": 1, "active": false},
    {"name": "Emily Clark", "experience": 7, "active": true},
    {"name": "Frank Harris", "experience": 2, "active": true},
    {"name": "Grace Lee", "experience": 4, "active": false},
    {"name": "Henry Wilson", "experience": 6, "active": true},
    {"name": "Isabel Young", "experience": 9, "active": true}
  ];

  void as ()async{
    SharedPreferences pr = await SharedPreferences.getInstance();
  pr.setString("data", jsonEncode(employees));

  }

  void gg() async{
    SharedPreferences pr = await SharedPreferences.getInstance();
    controller.aa.value = jsonDecode(pr.getString("data")?? "{}");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    as();
  }
  @override
  Widget build(BuildContext context) {
    gg();
    double ww = Get.width;
    double hh = Get.height;
    List<dynamic> aa = controller.aa;
    aa.sort((a, b) {
      if ((b['experience'] > 5 && b['active']) && !(a['experience'] > 5 && a['active'])) {
        return 1;
      } else if ((a['experience'] > 5 && a['active']) && !(b['experience'] > 5 && b['active'])) {
        return -1;
      } else {
        return b['experience'].compareTo(a['experience']);
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Employees",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: aa.length,
          itemBuilder: (context,index)
      {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: hh*0.025, horizontal: ww*0.07),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (aa[index]["experience"]>5 && aa[index]["active"])? Colors.green : Colors.white,
            ),

            child: ListTile(
              contentPadding: EdgeInsets.all(5),


              leading: Padding(
                padding:  EdgeInsets.only(left: 4.0),
                child: Text("${index+1}",style: TextStyle(fontSize: 15),),
              ),
              title: Text(aa[index]["name"],style: TextStyle(fontSize: 17)),
              trailing: Padding(
                padding:  EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Experience: ${aa[index]["experience"]}",style: TextStyle(fontSize: 12)),
                    Text("Is active in the company: ${aa[index]["active"]}",style: TextStyle(fontSize: 12))
                  ],
                ),
              ),

            ),
          ),
        );
      }),
    );
  }
}
