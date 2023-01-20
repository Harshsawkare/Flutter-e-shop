

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/Screens/Account.dart';
import 'package:eshop/Screens/Product.dart';
import 'package:eshop/Services/FirebaseServices.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/Services/apis.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final String uid;
  const Homepage({Key? key, required this.uid}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List products = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await API().getProducts().then((value){
      if(value != null){
        setState(() {
          products = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryDark,

        body: Stack(
          children: [

            ///appbar
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              color: secondaryLight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("e-Shop",
                      style: TextStyle(
                          color: primaryLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "poppins"
                      ),
                    ),
                    Expanded(child: SizedBox()),

                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.uid)
                        .snapshots(),
                      builder: (context, snapshot) {

                        if(!snapshot.hasData){
                          return SizedBox.shrink();
                        }

                        String photo = "";

                        try{
                          photo = snapshot.data!["photo"];
                        }catch(e){}

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                Account(uid: widget.uid,)
                            ));
                          },
                          child: Hero(
                            tag: widget.uid,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: primaryDark,
                                shape: BoxShape.circle
                              ),
                              child: photo.isNotEmpty ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(photo, fit: BoxFit.cover,),
                                  ) :
                              Center(
                                child: Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),

            ///body
            Padding(
              padding: EdgeInsets.only(top: 90),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                child: products.length == 0 ?
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 30,
                          height: 30,
                          child: Center(child: CircularProgressIndicator(color: secondaryLight,))
                      ),
                    ) :
                GridView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 50),
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 300),
                    itemBuilder: (context, index){

                          return ProductCard(
                            odd: index%2 != 0,
                            data: products[index],
                          );
                        }
                    )
                ),
              ),

          ],
        ),

      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final bool odd;
  final Map data;
  const ProductCard({Key? key,
    required this.odd,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with AutomaticKeepAliveClientMixin{

   String thumbnail = "";
   String title = "";
   String description = "";
   String price = "";
   String discountPercentage = "";
   String discountedPrice = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {

    setState(() {
      thumbnail = widget.data["thumbnail"];
      title = widget.data["title"];
      description = widget.data["description"];
      price = widget.data["price"].toString();
      discountPercentage = widget.data["discountPercentage"].toString();
    });

    setState(() {
      discountedPrice = ((double.parse(price) - (((double.parse(price)) * (double.parse(discountPercentage))) / 100))).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: widget.odd ? 10 : 20, right: widget.odd ? 20 : 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Product(product: widget.data)
          ));
        },
        child: Container(
          height: 280,
          decoration: BoxDecoration(
            color: primaryLight,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    ///image
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(thumbnail, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),

                    ///Product title
                    Container(
                      child: Text(title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "poppins"
                        ),
                      ),
                    ),

                    ///description
                    Container(
                      child: Text(description,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: "poppins"
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),

                    ///price
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("config")
                              .doc("offers")
                              .snapshots(),
                        builder: (context, snapshot) {

                            if(!snapshot.hasData){
                              return SizedBox.shrink();
                            }

                            bool showDiscount = false;

                            try{
                              showDiscount = snapshot.data!["giveDiscounts"];
                            }catch(e){}

                          return showDiscount ?
                            RichText(
                            text:  TextSpan(
                              text: '',
                              children: <TextSpan>[
                                 TextSpan(
                                  text: '\$${price}  ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: "poppins",
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                 TextSpan(
                                    text: ' \$$discountedPrice  ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "poppins",
                                      fontSize: 10,
                                    )
                                ),
                                 TextSpan(
                                  text: ' ${discountPercentage}% off',
                                  style: TextStyle(
                                    color: Colors.lightGreen,
                                    fontFamily: "poppins",
                                    fontSize: 10,
                                  )
                                ),
                              ],
                            ),
                          ) :
                          Text(
                            '\$${price}  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: "poppins",
                            ),
                          );
                        }
                      ),
                    ),

                  ],
                ),
              ),
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
