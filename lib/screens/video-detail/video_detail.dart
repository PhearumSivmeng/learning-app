// video_detail_screen.dart
import 'package:demo/data/models/video_model.dart';
import 'package:demo/data/models/video_play_model.dart';
import 'package:demo/widget/videoItem_component.dart';
import 'package:flutter/material.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class VideoDetailScreen extends StatefulWidget {
  final String videoId;

  const VideoDetailScreen({super.key, required this.videoId});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late final ApiClient apiClient;
  late final http.Client client;
  late VideoPlayerController? _videoController;
  late List<Comment> _comments;
  bool _isLoadingVideo = true;
  bool _hasError = false;
  VideoDetails? _details;
  late List<VideoModel> futureVideos;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    _comments = [];
    futureVideos = [];
    fetchVideoDetails();
    fetchVideoRelated();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    client.close();
    super.dispose();
  }

  void _updateComments() {
    if (_details != null) {
      setState(() {
        _comments = [
          Comment(
            id: '1',
            author: _details!.instructor,
            authorImage: _details!.profile
                .replaceAll("192.168.58.239:8080", "10.0.2.2:8000"),
            text: 'This tutorial was really helpful! Thanks for sharing.',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ];
      });
    }
  }

  Future<void> fetchVideoDetails() async {
    try {
      final res = await apiClient.getVideoDetails(arg: {"id": widget.videoId});
      final details = res.records;

      if (details != null) {
        setState(() {
          _details = details;
        });
        _updateComments();
        _initializeVideoPlayer(details.video);
      } else {
        setState(() => _hasError = true);
      }
    } catch (e) {
      setState(() => _hasError = true);
      debugPrint("Error loading video details: $e");
    }
  }

  Future<void> fetchVideoRelated() async {
    try {
      final res = await apiClient
          .onGetVideos(arg: {"type": "relates", "id": widget.videoId});
      final details = res.records;

      if (details != null) {
        setState(() {
          futureVideos = details;
        });
      } else {
        setState(() => _hasError = true);
      }
    } catch (e) {
      setState(() => _hasError = true);
      debugPrint("Error loading video details: $e");
    }
  }

  void _initializeVideoPlayer(String videoUrl) async {
    try {
      final processedUrl =
          videoUrl.replaceAll("192.168.58.239:8080", "10.0.2.2:8000");
      final encodedUrl = Uri.parse(processedUrl).toString();

      _videoController = VideoPlayerController.network(encodedUrl);

      try {
        await _videoController!.initialize();
        setState(() => _isLoadingVideo = false);
      } catch (e) {
        debugPrint("Video initialization error: $e");
        if (e is PlatformException) {
          debugPrint("Platform exception details: ${e.message}");
        }
        setState(() {
          _isLoadingVideo = false;
          _hasError = true;
        });
      }
    } catch (e) {
      debugPrint("Video controller creation error: $e");
      setState(() {
        _isLoadingVideo = false;
        _hasError = true;
      });
    }
  }

  void _onPlayButtonPressed() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      setState(() {
        _videoController!.value.isPlaying
            ? _videoController!.pause()
            : _videoController!.play();
      });
    } else {
      // Try to initialize again if there was an error
      if (_details != null) {
        setState(() {
          _isLoadingVideo = true;
          _hasError = false;
        });
        _initializeVideoPlayer(_details!.video);
      }
    }
  }

  final TextEditingController _commentController = TextEditingController();
  void _submitComment() {
    if (_commentController.text.trim().isEmpty) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: 'Current User', // Replace with actual user name
      authorImage: '', // Replace with actual user image
      text: _commentController.text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _comments.insert(0, newComment);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_details == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final thumbnailUrl =
        _details!.thumbnail.replaceAll("192.168.58.239:8080", "10.0.2.2:8000");

    return Scaffold(
      appBar: AppBar(title: Text(_details!.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: _isLoadingVideo
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 8),
                            Text("Loading video...",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      )
                    : _hasError ||
                            _videoController == null ||
                            !_videoController!.value.isInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                thumbnailUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.white, size: 50),
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  iconSize: 60,
                                  icon: const Icon(Icons.play_circle_filled,
                                      color: Colors.white),
                                  onPressed: _onPlayButtonPressed,
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              VideoPlayer(_videoController!),
                              VideoProgressIndicator(
                                _videoController!,
                                allowScrubbing: true,
                                padding: const EdgeInsets.all(8),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  iconSize: 60,
                                  icon: Icon(
                                    _videoController!.value.isPlaying
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    color: Colors.white,
                                  ),
                                  onPressed: _onPlayButtonPressed,
                                ),
                              )
                            ],
                          ),
              ),
            ),
            // Always show these details regardless of video state
            const SizedBox(height: 16),
            Text(
              _details!.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    _details!.profile
                        .replaceAll("192.168.58.239:8080", "10.0.2.2:8000"),
                  ),
                ),
                const SizedBox(width: 10),
                Text(_details!.instructor),
                const Spacer(),
                const Icon(Icons.remove_red_eye, size: 16),
                const SizedBox(width: 4),
                Text('${_details!.views} views'),
              ],
            ),
            const SizedBox(height: 16),
            Text("Category: ${_details!.category}"),
            Text("Technology: ${_details!.technology}"),
            const SizedBox(height: 16),
            Text(
              _details!.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submitComment,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Comments list
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _comments.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return CommentItem(comment: comment);
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Related Videos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Column(
              children: futureVideos.map((item) {
                return VideoitemComponent(
                  id: item.id,
                  title: item.title,
                  thumbnail: item.thumbnail,
                  views: item.views,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

// Add this Comment model class (either in a new file or above your widget class)
class Comment {
  final String id;
  final String author;
  final String authorImage;
  final String text;
  final DateTime timestamp;
  final int likes;

  Comment({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.text,
    required this.timestamp,
    this.likes = 0,
  });
}

// Add this CommentItem widget class outside your _VideoDetailScreenState class
class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(comment.authorImage),
            ),
            const SizedBox(width: 8),
            Text(
              comment.author,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              DateFormat('MMM d, y').format(comment.timestamp),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(comment.text),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_up, size: 16),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text(comment.likes > 0 ? comment.likes.toString() : ''),
            const SizedBox(width: 16),
            const Text('Reply', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
