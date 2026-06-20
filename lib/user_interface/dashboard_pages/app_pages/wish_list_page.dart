import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class WishlListPage extends StatefulWidget {
  @override
  State<WishlListPage> createState() => _WishlListPageState();
}

class _WishlListPageState extends State<WishlListPage> {
  List<String> saleSlides = [
    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_retail-sale-posters-362a517f195f1af49f562d3f925c2c12.jpg?ts%20=%201706181157",
    "https://edit.org/img/blog/z3i-sale-poster-template-free-edit-online.webp",
    "https://i.pinimg.com/736x/80/0e/7c/800e7ce624197ee30048c32d2b57254f.jpg",
    "https://t4.ftcdn.net/jpg/04/86/53/23/360_F_486532393_IZOMHnhTFf7d88iDT8YCNAhSq6FRjd5u.jpg",
    "https://edit.org/img/blog/3q9-free-sale-sign-templates-online.webp",
    "https://image.shutterstock.com/image-vector/winter-big-sale-banner-snow-260nw-2698748061.jpg",
    "https://dynamic.design.com/template/preview/design/30bad16b-9d9a-4abf-a6c9-ca66cadd9b62?v=4&designTemplateVersion=1&size=design-preview-tall-2x&layout=auto-1-1"
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo87yQLScGu6Qk1DnlHUDDtTHe6T9citZiwg&s",
    "https://i.pinimg.com/736x/5b/c4/de/5bc4de18edff4b8436ac37a57ff168a1.jpg",
  ];

  List<String> productImages = [
    "https://shop.timexindia.com/cdn/shop/files/TWEG26704_1.jpg?v=1748513330",
    "https://m.media-amazon.com/images/I/81ZQ1YJ1xQL._AC_UY1000_.jpg",
    "https://shop.timexindia.com/cdn/shop/files/02680_WB23_September_flatlay_background_imagery_TW2W10400_mobile_3e2ec263-8e8f-4f42-a653-a9f268ac4e17.jpg?v=1759837905",
    "https://www.watches.com/cdn/shop/files/timex-marlin-chronograph-tachymeter-40mm-blue-tw2w99000vq-188772_1080x.jpg?v=1749278049",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: productImages.length,
              itemBuilder: (context, index, _) {
                return Container(
                  height: 270,
                  margin: EdgeInsets.only(right: 15),
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
                          decorator: DotsDecorator(color: Colors.red),
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
          ],
        ),
      ),
    );
  }
}
