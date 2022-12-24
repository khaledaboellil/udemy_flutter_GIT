import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/user/user_models.dart';

class userscreen extends StatelessWidget {

  List<usermodle> users = [
    usermodle(id: 1, user: "khaled Aboellil", number: "01067808122") ,
    usermodle(id: 2, user: "Ahmed Aboellil", number: "01069725063") ,
    usermodle(id: 3, user: "Mohamed Aboellil", number: "01005804403"),
    usermodle(id: 4, user: "Azza manie", number: "01012882850"),
    usermodle(id: 5, user: "basant Aboellil", number: "01015448780"),
    usermodle(id: 1, user: "khaled Aboellil", number: "01067808122") ,
    usermodle(id: 2, user: "Ahmed Aboellil", number: "01069725063") ,
    usermodle(id: 3, user: "Mohamed Aboellil", number: "01005804403"),
    usermodle(id: 4, user: "Azza manie", number: "01012882850"),
    usermodle(id: 5, user: "basant Aboellil", number: "01015448780"),
    usermodle(id: 1, user: "khaled Aboellil", number: "01067808122") ,
    usermodle(id: 2, user: "Ahmed Aboellil", number: "01069725063") ,
    usermodle(id: 3, user: "Mohamed Aboellil", number: "01005804403"),
    usermodle(id: 4, user: "Azza manie", number: "01012882850"),
    usermodle(id: 5, user: "basant Aboellil", number: "01015448780"),
  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users")
      ) ,
        body : ListView.separated(
            itemBuilder: (contex,index)=>BuildUserItem(users[index])
            , separatorBuilder: (contex,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Container(width: double.infinity,
                height: 1 ,
                color: Colors.grey,
              ),
            )

            , itemCount: users.length)


    );
  }
}
Widget BuildUserItem(usermodle user)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: <Widget>[
      CircleAvatar(
        radius: 30,
        child: Text('${user.id}',style: TextStyle(
          fontSize: 20 ,
          fontWeight: FontWeight.bold ,
        ),),
      ),
      SizedBox(width: 10,),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${user.user}"
            ,style: TextStyle(
              fontSize: 20 ,
              fontWeight: FontWeight.bold ,
            ),),
          Text("${user.number}",style: TextStyle(color: Colors.grey),),
        ],
      ),
    ],
  ),
) ;
