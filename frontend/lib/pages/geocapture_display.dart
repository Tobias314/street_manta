import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:street_manta_client/api/authentication.dart';
import 'package:street_manta_client/api/geocapture.dart';
import 'package:street_manta_client/models/geocapture.dart';
import 'package:video_player/video_player.dart';

class GeoCaptureDisplayPage extends StatefulWidget {
  final GeoCaptureDescriptor geoCaptureDescriptor;

  const GeoCaptureDisplayPage({
    Key? key,
    required this.geoCaptureDescriptor,
  }) : super(key: key);

  @override
  State<GeoCaptureDisplayPage> createState() => _GeoCaptureDisplayPageState();
}

class _GeoCaptureDisplayPageState extends State<GeoCaptureDisplayPage> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    if (widget.geoCaptureDescriptor.video != null) {
      print(
          'Initializing video for url: ${widget.geoCaptureDescriptor.video!.url}');
      getUserToken().then((token) {
        _videoController = VideoPlayerController.networkUrl(
            Uri.parse(
                widget.geoCaptureDescriptor.video!.url + '?user_token=$token'),
            httpHeaders: {
              'Content-type': 'application/json',
              'Accept': 'video/mp4',
              'Authorization': 'Bearer $token',
            });

        _videoController!.initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
        }).catchError((error) {
          print('Error initializing video: $error');
        });
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Capture: ${widget.geoCaptureDescriptor.captureId}'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description section
            if (widget.geoCaptureDescriptor.description.isNotEmpty) ...[
              Text(
                'Description',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.geoCaptureDescriptor.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
            ],
            const SizedBox(height: 24),

            // Photos section
            if (widget.geoCaptureDescriptor.photos.isNotEmpty) ...[
              Text(
                'Photos (${widget.geoCaptureDescriptor.photos.length})',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.geoCaptureDescriptor.photos.length,
                itemBuilder: (context, index) {
                  final photo = widget.geoCaptureDescriptor.photos[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: FutureBuilder(
                              future: fetchImageBytes(photo.url),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.memory(snapshot.data!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error,
                                              color: Colors.red, size: 48),
                                          Text('Failed to load image'),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                // By default, show a loading spinner.
                                return Container(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Photo ID: ${photo.photoId}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Location: ${photo.position.latitude.toStringAsFixed(6)}, ${photo.position.longitude.toStringAsFixed(6)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                'Elevation: ${photo.position.elevation.toStringAsFixed(2)}m',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],

            // Video section
            if (widget.geoCaptureDescriptor.video != null) ...[
              Text(
                'Video',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isVideoInitialized && _videoController != null) ...[
                      AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                      VideoControls(controller: _videoController!),
                    ] else ...[
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 8),
                              Text('Loading video...'),
                            ],
                          ),
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Video ID: ${widget.geoCaptureDescriptor.video!.videoId}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            ...[
              Center(
                  child: TextButton(
                onPressed: () {
                  downloadGeoCapture(widget.geoCaptureDescriptor.captureId);
                },
                child: Text('Download'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
              ))
            ]
          ],
        ),
      ),
    );
  }
}

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoControls({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          VideoProgressIndicator(
            widget.controller,
            allowScrubbing: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(widget.controller.value.position),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.controller.value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                      });
                    },
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.seekTo(Duration.zero);
                    },
                    icon: const Icon(Icons.replay),
                  ),
                ],
              ),
              Text(
                _formatDuration(widget.controller.value.duration),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
