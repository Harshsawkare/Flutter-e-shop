import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';


class Product extends StatefulWidget {
  final Map product;
  const Product({Key? key, required this.product}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  String price = "";
  String discountPercentage = "";
  String discountedPrice = "";
  int pageIndex=0;
  List images= [];

  void initState() {
    getData();
    super.initState();
  }

  void getData() {

    setState(() {
      price = widget.product["price"].toString();
      images = widget.product["images"].toList();
      discountPercentage = widget.product["discountPercentage"].toString();
    });

    setState(() {
      discountedPrice = ((double.parse(price) - (((double.parse(price)) * (double.parse(discountPercentage))) / 100))).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLight,

      appBar: AppBar(
        backgroundColor: secondaryLight,
        elevation: 0,
        title: Text("Product",
          style: TextStyle(
              color: primaryLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "poppins"
          ),
        ),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///images
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index){
                      setState(() {
                        pageIndex=index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {

                      return Container(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade200,
                        child: Image.network(images[index], fit: BoxFit.contain,),
                      );

                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselIndicator(
                      count: images.length,
                      index: pageIndex,
                      color: Colors.grey.shade300,
                      activeColor: Colors.grey,
                    ),
                  ],
                ),

                ///Product title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(widget.product['title'],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "poppins"
                    ),
                  ),
                ),

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
                                  fontSize: 12,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                  text: ' \$$discountedPrice  ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "poppins",
                                    fontSize: 16,
                                  )
                              ),
                              TextSpan(
                                  text: ' ${discountPercentage}% off',
                                  style: TextStyle(
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "poppins",
                                    fontSize: 16,
                                  )
                              ),
                            ],
                          ),
                        ) :
                        Text(
                          '\$${price}  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "poppins",
                          ),
                        );
                      }
                  ),
                ),

                ///description
                Divider(),
                Text(widget.product['description'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "poppins"
                  ),
                ),
                Divider(),

                ///instock
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("${widget.product['stock'].toString()} available in stock",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: "poppins"
                    ),
                  ),
                ),

                ///chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    ///brand
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: secondaryLight),
                        color: secondaryLight.withOpacity(0.2)
                      ),
                      child: Text(widget.product["brand"]),
                    ),
                    SizedBox(width: 10,),

                    ///category
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: secondaryLight),
                          color: secondaryLight.withOpacity(0.2)
                      ),
                      child: Text(widget.product["category"]),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
