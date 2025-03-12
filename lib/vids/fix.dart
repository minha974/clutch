import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FixPage extends StatelessWidget {
  final List<Map<String, String>> vids = [
    {
      'title': 'How to pour coolant',
      'description': 'Watch this if ur engine is heating up',
      'yt_id': 'KEKDssWK-ck',

    },
    {
      'title': 'How to change your oil',
      'description': 'learn how to change your oil',
      'yt_id': 'L4lc0meYkDY',

    },
    {
      'title': 'How to Repair Minor Windshield Damage',
      'description': 'repair your small windshield damage',
      'yt_id': 'PMIDwR9Y7bw',

    },
    {
      'title': 'How to change your tire',
      'description': 'Learn how to change your tire by watching the video',
      'yt_id': '314HE4aMG-g',

    },
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('F i x   i t   y o u r s e l f', style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.grey[500],
      ),
      backgroundColor: Colors.grey[500],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: vids.length,
          itemBuilder: (context, index) {
            final vid = vids[index];
            final String youtubeUrl = 'https://youtu.be/${vid['yt_id']}';
            final String thumbnailUrl =
                'https://img.youtube.com/vi/${vid['yt_id']}/0.jpg';

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
             color: Colors.grey[350],
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        thumbnailUrl,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 100, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      vid['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      vid['description']!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF86ab0c),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      onPressed: () => _launchURL(youtubeUrl),
                      child: Text(
                        'Watch on YouTube',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
