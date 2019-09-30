import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Placeholder extends StatefulWidget {
  String data;

  @override
  State<StatefulWidget> createState() {
    return new _PlaceholderState();
  }

  Placeholder(this.data);
}

class _PlaceholderState extends State<Placeholder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<Results> getTopRated() async {
    var URL = "http://api.themoviedb.org/3/movie/" +
        widget.data +
        "?api_key=832f13a97b5d2df50ecf0dbc8a0f46ae";
    http.get(URL).then((http.Response response) {
      print(response.body);
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      MovieResponse res = MovieResponse.fromJson(jsonDecode(response.body));
      return res.results;
    });
  }
}

class MovieResponse {
  int page;
  List<Results> results;

  MovieResponse({this.page, this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
        page: json["page"], results: getResults(json));
  }

  static List<Results> getResults(json) {
    var list = json['results'] as List;
    return list.map((i) => Results.fromJson(i)).toList();
  }
}

class Results {
  int id;
  String poster_path;
  String original_title;
  double vote_average;
  String overview;
  String release_date;

  Results(
      {this.id,
      this.poster_path,
      this.original_title,
//      this.vote_average,
      this.overview,
      this.release_date});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        id: json["id"],
        poster_path: json["poster_path"],
        original_title: json["original_title"],
//        vote_average: json["vote_average"],
        overview: json["overview"],
        release_date: json["release_date"]);
  }
}
