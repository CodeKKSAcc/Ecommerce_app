import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {

  List<String> images = [
    "asset/icons/shirt.png",
    "asset/icons/jacket.png",
    "asset/icons/jeans.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                images[index],
                                height: 90,
                                width: 90,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 12,),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Full Shirt(Mens)", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 90,),
                                      Icon(Icons.delete, color: Colors.deepOrangeAccent,),
                                    ],
                                  ),
                                  Text("Cloths", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("\$99.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 108,),
                                      Container(
                                        width: 120,
                                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                                        decoration: BoxDecoration(
                                           border: Border.all(),
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.remove),
                                            Text("1"),
                                            Icon(Icons.add)
                                          ],
                                        ),
                                      )                                ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
                Align(
                  alignment: Alignment(0, 0.93),
                  child: Container(
                    alignment: Alignment(0, 0),
                    height: 63,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                     // border: Border.all(style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Checkout", style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400, color: Colors.white),)
                  ),
                )
          ],
        ),
      ),
    );
  }
}
