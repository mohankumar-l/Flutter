import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../model/shop_list.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool isLiked = false;

  Future<List<ShopList>> fetchAlbum() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
  //   if (response.statusCode == 200) {
  //     return shopListFromJson(response.body);
  //   } else {
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        leading: const Icon(Icons.shopping_bag),
      ),
      body: SafeArea(
        child: FutureBuilder<List<ShopList>>(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  String title = snapshot.requireData[index].title;
                  dynamic image = snapshot.requireData[index].image;
                  String price = snapshot.requireData[index].price.toString();
                  String description =
                      snapshot.requireData[index].description.toString();
                  num ratings = snapshot.requireData[index].rating.rate;
                  String count =
                      snapshot.requireData[index].rating.count.toString();
                  return Card(
                    margin: const EdgeInsets.all(2),
                    shadowColor: Colors.indigo,
                    elevation: 20,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                child: Image.network(
                                  image,
                                  height: 120,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w100),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: ratings.toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 18,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text("($count)")
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "₹$price",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: GestureDetector(
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    size: 28,
                                    color: isLiked ? Colors.red : Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Text(
                                  description,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
