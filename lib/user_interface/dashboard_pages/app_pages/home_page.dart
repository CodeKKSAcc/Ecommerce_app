import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(shape: CircleBorder()),
          icon: Icon(Icons.menu_outlined, size: 24,),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(shape: CircleBorder()),
            icon: Icon(Icons.notifications, size: 24,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 21),
          child: Column(
            children: [
              // Top search bar
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21)
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search...",
                  suffixIcon: Icon(Icons.tune_outlined)
                ),
              ),
              SizedBox(height: 21,),
              // Product banner
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(),),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.75, 0.60),
                      child: Container(
                        alignment: Alignment(0, 0),
                        height: 36,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Shop Now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 21,),
              // Category Icon
              SizedBox(
                height: 120,
                child: ListView.builder(
                    itemCount: 12,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 78,
                        width: 78,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(39)
                        ),
                      ),
                      SizedBox(height: 9,),
                      Text("Item $index"),
                    ],
                  );
                }),
              ),
              SizedBox(height: 18,),
              // Special for you title
              Row(
                children: [
                  Text("Special for you", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text("See all", style: TextStyle(fontSize: 15),)
                ],
              ),
              SizedBox(height: 18,),
              // Item section
              GridView.builder(
                itemCount: 18,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12
                  ), itemBuilder: (context, index){
                return Container(
                  height: 180,
                  width: 45,
                  alignment: Alignment(0, 0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0.9, 0.9),
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                itemCount: 4,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, indx){
                                return Container(
                                  height: 20,
                                  width: 20,
                                  margin: EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

/*Image.network("https://www.magnific.com/free-photos-vectors/shoes-poster")*/