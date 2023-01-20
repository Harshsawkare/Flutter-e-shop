import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/Screens/Login.dart';
import 'package:eshop/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  final String uid;
  const Account({Key? key, required this.uid}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,

      appBar: AppBar(
        backgroundColor: secondaryLight,
        elevation: 0,
        title: Text("My Account",
          style: TextStyle(
              color: primaryLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "poppins"
          ),
        ),
      ),

      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .snapshots(),
        builder: (context, snapshot) {

          if(!snapshot.hasData){
            return SizedBox.shrink();
          }

          String name = "";
          String email = "";
          String photo = "";

          try{
            photo = snapshot.data!["photo"];
          }catch(e){}
          try{
            name = snapshot.data!["name"];
          }catch(e){}
          try{
            email = snapshot.data!["email"];
          }catch(e){}
          try{

          }catch(e){}

          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Column(
                children: [

                  ///info
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [

                        ///image
                        Hero(
                          tag: widget.uid,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: primaryDark,
                                shape: BoxShape.circle
                            ),
                            child: photo.isNotEmpty ?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(photo, fit: BoxFit.cover,),
                            ) :
                            Center(
                              child: Icon(Icons.person, color: Colors.white,),
                            ),
                          ),
                        ),

                        ///info
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "poppins"
                                ),
                              ),
                              Text(email,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: "poppins"
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  ///points
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10) + EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryLight,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [

                                ///Edit profile info
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 20, color: Colors.grey.shade700,),
                                      Text("  Edit profile info",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontFamily: "poppins"
                                        ),
                                      ),
                                      Expanded(child: SizedBox(),),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey.shade700,)
                                    ],
                                  ),
                                ),
                                Divider(),

                                ///My orders
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.grey.shade700,),
                                      Text("  My orders",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontFamily: "poppins"
                                        ),
                                      ),
                                      Expanded(child: SizedBox(),),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey.shade700,)
                                    ],
                                  ),
                                ),
                                Divider(),

                                ///My transactions
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.currency_exchange, size: 20, color: Colors.grey.shade700,),
                                      Text("  My transactions",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontFamily: "poppins"
                                        ),
                                      ),
                                      Expanded(child: SizedBox(),),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey.shade700,)
                                    ],
                                  ),
                                ),
                                Divider(),

                                ///My Favourites
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.favorite_outline_rounded, size: 20, color: Colors.grey.shade700,),
                                      Text("  My Favourites",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontFamily: "poppins"
                                        ),
                                      ),
                                      Expanded(child: SizedBox(),),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey.shade700,)
                                    ],
                                  ),
                                ),
                                Divider(),

                                ///Logout
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut().then((value){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          Login()
                                      ));
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    child: Center(
                                      child: Text("Logout",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontWeight:FontWeight.bold,
                                            fontFamily: "poppins"
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),

                              ],
                            ),
                          ),
                        ),
                      )
                  )

                ],
              )
          );
        }
      ),
    );
  }
}
