import 'package:anime_flix/database/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Animes extends StatefulWidget {
  const Animes({Key? key}) : super(key: key);

  @override
  _AnimesState createState() => _AnimesState();
}

class _AnimesState extends State<Animes> {
  late Future<List<Show>> shows;

  Future<List<Show>> fetchShows() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));

    if (response.statusCode == 200) {
      var topShowsJson = jsonDecode(response.body)['top'] as List;
      return topShowsJson.map((show) => Show.fromJson(show)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Show>> snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${snapshot.data?[index].imageUrl}'),
                      ),
                      title: Text('${snapshot.data?[index].title}'),
                      subtitle: Text('Score: ${snapshot.data?[index].score}'),
                      trailing: Text('Epsódios: ${snapshot.data?[index].episodes}'),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong :('));
            }

            return CircularProgressIndicator();
          },
          future: shows,
        ),
      ),
    );
  }
}
