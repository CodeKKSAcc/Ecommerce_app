import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedOne = 1;
  String productData = "";

  List<String> productImages = [
    "https://shop.timexindia.com/cdn/shop/files/TWEG26704_1.jpg?v=1748513330",
    "https://m.media-amazon.com/images/I/81ZQ1YJ1xQL._AC_UY1000_.jpg",
    "https://shop.timexindia.com/cdn/shop/files/02680_WB23_September_flatlay_background_imagery_TW2W10400_mobile_3e2ec263-8e8f-4f42-a653-a9f268ac4e17.jpg?v=1759837905",
    "https://www.watches.com/cdn/shop/files/timex-marlin-chronograph-tachymeter-40mm-blue-tw2w99000vq-188772_1080x.jpg?v=1749278049",
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedOne == 1) {
      productData =
          "Our Bluetooth earbuds bring together style, comfort, and cutting-edge technology "
          "to deliver an exceptional listening experience. With advanced Bluetooth 5.3, "
          "they connect seamlessly to your devices, ensuring a stable and lag-free performance"
          "whether you’re streaming music, taking calls, or watching videos. The sound quality"
          " is rich and immersive, with deep bass, crisp highs, and balanced mids that make every"
          " track come alive. Designed with ergonomics in mind, the lightweight build and soft silicone"
          " tips provide a secure fit that stays comfortable throughout the day, whether you’re at the"
          " gym, commuting, or relaxing at home. A long-lasting battery offers up to six hours of playtime"
          " on a single charge, with an additional twenty-four hours stored in the sleek charging case,"
          " so you’re never without your music. Sweat and water resistance make them reliable companions for"
          " workouts and outdoor adventures, while intuitive touch controls let you manage playback and calls"
          " effortlessly. These earbuds are more than just an accessory—they’re your everyday partner for freedom"
          ", convenience, and premium sound. Battery life is built to keep up with your day, offering up to six hours"
          " of continuous playtime on a single charge, with the compact charging case extending that to a full thirty "
          "hours of listening freedom. The case itself is lightweight and pocket-friendly, making it easy to carry "
          "wherever you go. For those who live an active lifestyle, the earbuds are sweat and water resistant, giving "
          "you the confidence to push through intense workouts or unexpected weather without worry. Intuitive touch "
          "controls let you manage your music, adjust volume, or answer calls with a simple tap, keeping convenience "
          "literally at your fingertips."
          "Beyond performance, these earbuds are about freedom—freedom from tangled wires, freedom to move, "
          "and freedom to enjoy your audio world without compromise. They’re not just another accessory; "
          "they’re a daily essential that blends seamlessly into your routine, elevating every moment with "
          "premium sound and effortless usability. Whether you’re a music enthusiast, a professional on the "
          "go, or someone who values comfort and style, these Bluetooth earbuds are crafted to meet your needs "
          "and exceed your expectations.";
    } else if (selectedOne == 2) {
      productData =
          "The earbuds feature the latest Bluetooth 5.3 technology, ensuring fast pairing and a"
          " stable connection across smartphones, tablets, and laptops. Each earbud is equipped with high-performance"
          " audio drivers that deliver a balanced sound profile, combining deep bass, clear mids, and crisp highs for"
          " an immersive listening experience. The ergonomic design includes lightweight construction and soft silicone ear"
          " tips, providing a secure and comfortable fit that remains stable during workouts or extended use. Battery performance"
          " is impressive, offering up to six hours of continuous playback on a single charge, while the compact charging case "
          "extends total usage to thirty hours, making them ideal for travel or long days on the go. The case itself is sleek and"
          " portable, designed to slip easily into a pocket or bag."
          "For convenience, the earbuds come with intuitive touch controls that allow you to manage music playback, adjust volume, skip"
          " tracks, and answer calls with a simple tap. Built-in noise isolation helps reduce ambient distractions, enhancing both"
          " music and call clarity. With an IPX5 water and sweat resistance rating, they are durable enough to withstand intense workouts"
          " and light rain. The earbuds also include a built-in microphone for hands-free calling, ensuring clear communication even in"
          " busy environments. Altogether, these specifications combine to create a product that balances performance,"
          " comfort, and durability, making the earbuds a reliable companion for everyday use.";
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(shape: CircleBorder()),
            icon: Icon(Icons.share),
          ),
          SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(shape: CircleBorder()),
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    CarouselSlider.builder(
                      itemCount: productImages.length,
                      itemBuilder: (context, index, _) {
                        return Container(
                          height: 270,
                          margin: EdgeInsets.only(right: 15, top: 25, bottom: 21),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(productImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment(0, 1),
                                child: DotsIndicator(
                                  dotsCount: productImages.length,
                                  decorator: DotsDecorator(size: Size(24, 12), activeSize: Size(24, 12), shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)), color: Colors.green),
                                  position: index.toDouble(),
                                  animate: true,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.87,
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                    ),
                    // Wireless Headphone
                    Text(
                      "Timex Marlin Watch",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$900.00",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 63,
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 6),
                                      Icon(Icons.star, color: Colors.white),
                                      SizedBox(width: 3),
                                      Text(
                                        "4.8",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "(321 Review)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Seller: ",
                            style: TextStyle(fontSize: 21),
                            children: [
                              TextSpan(
                                text: "KKS",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    // Color title and Colors
                    Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 48,
                            width: 48,
                            margin: EdgeInsets.only(right: 9),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 21),
                    StatefulBuilder(
                      builder: (context, sS) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                selectedOne = 1;
                                setState(() {
                                  print(selectedOne);
                                });
                              },
                              child: (selectedOne == 1 || selectedOne == 0)
                                  ? Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                selectedOne = 2;
                                setState(() {
                                  print(selectedOne);
                                });
                              },
                              child: (selectedOne == 2)
                                  ? Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "Specifications",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Specifications",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                selectedOne = 3;
                                setState(() {
                                  print(selectedOne);
                                });
                              },
                              child: (selectedOne == 3)
                                  ? Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "Reviews",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Reviews",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 18),
                    (selectedOne == 1 || selectedOne == 2)
                        ? Text(
                            productData,
                            style: TextStyle(
                              fontSize: 18,
                              /* fontWeight: FontWeight.bold, */
                              color: Colors.black54,
                            ),
                          )
                        : ListView.builder(
                            itemCount: 5,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star),
                                    SizedBox(width: 9),
                                    Text("5"),
                                  ],
                                ),
                                title: Text("Nice Product"),
                              );
                            },
                          ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Container(
                        height: 63,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.96),
              child: Container(
                padding: EdgeInsets.all(9),
                height: 84,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff000000),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(39),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 135,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      margin: EdgeInsets.symmetric(
                        horizontal: 9,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.remove, color: Colors.white),
                          Text(
                            "1",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Icon(Icons.add, color: Colors.white),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 60,
                      width: 210,
                      /*margin: EdgeInsets.all(9),*/
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
