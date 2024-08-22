import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Feed>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  Future<List<Feed>> fetchAlbums() async {
    final response = await http.get(
        Uri.parse('https://itunes.apple.com/in/rss/topalbums/limit=25/json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> albums = data['feed']['entry'];

      return albums.map<Feed>((json) => Feed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Feed>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Feed> feeds = snapshot.data!;
            return ListView.builder(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(feeds[index].imageUrl),
                  title: Text(feeds[index].name),
                  subtitle: Text(feeds[index].artist),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Feed {
  final String name;
  final String artist;
  final String imageUrl;

  Feed({
    required this.name,
    required this.artist,
    required this.imageUrl,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      name: json['im:name']['label'],
      artist: json['im:artist']['label'],
      imageUrl: json['im:image'][2]['label'],
    );
  }
}
