import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:buttons_flutter/buttons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-09-27&sortBy=publishedAt&apiKey=18c2438c4da84cce95dd5eb03a3f3c01'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Text(
          'Pick Your choice',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('Business headlines'),
              onTap: () {
                // Handle item 1 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const headline()),);
              },
            ),
            ListTile(
              title: Text('Tech News'),
              onTap: () {
                // Handle item 1 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const article()),);
              },
            ),
          ],
        ),
      ),

      body:
       FutureBuilder<List<dynamic>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return  Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (article['urlToImage'] != null)
                        Image.network(article['urlToImage']),
                      const SizedBox(height: 8),
                      Text(
                        article['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article['publishedAt'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                                TextButton(
          onPressed: () async {
            final url = article['url'] ?? '';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text(
            'Read', // Display the word "URL" instead of the entire URL
            style: TextStyle(color: Colors.blue),
          ),
        ),


                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
/////////////////////////////////////
class headline extends StatelessWidget {
  const headline({super.key});
Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2024-10-17&to=2024-10-17&sortBy=popularity&apiKey=18c2438c4da84cce95dd5eb03a3f3c01'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
    
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
          'Pick Your choice',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
            
              decoration: BoxDecoration(
                color: Colors.black,
                
              ),
            ),
            ListTile(
              title: Text('Business headlines'),
              
              onTap: () {
                // Handle item 1 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const headline()),);
              },
            ),
            ListTile(
              title: Text('Tech News'),
              onTap: () {
                // Handle item 2 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const article()),);
              },
            ),
          ],
        ),
      ),

      body:
       FutureBuilder<List<dynamic>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return  Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (article['urlToImage'] != null)
                        Image.network(article['urlToImage']),
                      const SizedBox(height: 8),
                      Text(
                        article['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article['publishedAt'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                       TextButton(
          onPressed: () async {
            final url = article['url'] ?? '';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text(
            'Read', // Display the word "URL" instead of the entire URL
            style: TextStyle(color: Colors.blue),
          ),
        ),
                     
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
  /////////////////////////////
  class article extends StatelessWidget {
  const article({super.key});
Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=18c2438c4da84cce95dd5eb03a3f3c01'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
          'Pick Your choice',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
            
              decoration: BoxDecoration(
                color: Colors.black,
                
              ),
            ),
            ListTile(
              title: Text('Business headlines'),
              
              onTap: () {
                // Handle item 1 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const headline()),);
              },
            ),
            ListTile(
              title: Text('Tech News'),
              onTap: () {
                // Handle item 2 tap
               Navigator.push(context,MaterialPageRoute(builder: (context)=> const article()),);
              },
            ),
          ],
        ),
      ),

      body:
       FutureBuilder<List<dynamic>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return  Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (article['urlToImage'] != null)
                        Image.network(article['urlToImage']),
                      const SizedBox(height: 8),
                      Text(
                        article['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article['publishedAt'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                       TextButton(
          onPressed: () async {
            final url = article['url'] ?? '';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text(
            'Read', // Display the word "URL" instead of the entire URL
            style: TextStyle(color: Colors.blue),
          ),
        ),
                     
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
  