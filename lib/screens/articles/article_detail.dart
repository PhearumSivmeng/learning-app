import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/models/technology_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetailScreen extends StatelessWidget {
  final AritcleModel article;

  const ArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('[ ${article.title} ]'),
      ),
      backgroundColor: MyTheme.bodyBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            if (article.thumbnail.isNotEmpty)
              CachedNetworkImage(
                imageUrl: article.thumbnail
                    .replaceAll('192.168.70.70:8080', '10.0.2.2:8000'),
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article.title,
                  ),
                  const SizedBox(height: 8),

                  // Short details
                  Text(
                    article.shortDetails,
                  ),
                  const SizedBox(height: 16),

                  // HTML content
                  Html(
                    data: article.description,
                    style: {
                      "h1": Style(
                        fontSize: FontSize.larger,
                        fontWeight: FontWeight.bold,
                        margin: Margins.only(bottom: 8),
                      ),
                      "h2": Style(
                          fontSize: FontSize.large,
                          fontWeight: FontWeight.bold,
                          margin: Margins.only(bottom: 8)),
                      "h3": Style(
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.bold,
                          margin: Margins.only(bottom: 8)),
                      "p": Style(margin: Margins.only(bottom: 8)),
                      "ul": Style(margin: Margins.only(bottom: 8)),
                      "li": Style(margin: Margins.only(bottom: 4)),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
