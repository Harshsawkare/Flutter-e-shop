import 'package:eshop/constants.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                padding: const EdgeInsets.only(bottom: 10, left: 20),
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

                child: GridView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 50),
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 280),
                    itemBuilder: (context, index){

                      return ProductCard(odd: index%2 != 0,);
                    }
                ),
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
  const ProductCard({Key? key, required this.odd}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: widget.odd ? 10 : 20, right: widget.odd ? 20 : 10),
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),

              ///Product Name
              Container(
                child: Text("Product Name",
                  textAlign: TextAlign.start,
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
                child: Text("Product description product description product description product description product description product description",
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
              RichText(
                text: new TextSpan(
                  text: '',
                  children: <TextSpan>[
                    new TextSpan(
                      text: '\$8.99  ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontFamily: "poppins",
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    new TextSpan(
                        text: ' \$3.99  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "poppins",
                          fontSize: 10,
                        )
                    ),
                    new TextSpan(
                      text: ' 12.76% off',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontFamily: "poppins",
                        fontSize: 10,
                      )
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),

            ],
          ),
        ),
      ),
    );
  }
}
