import 'package:animations/animations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/gif_model.dart';

class GifGenerator extends StatefulWidget {
  const GifGenerator({super.key});

  @override
  State<GifGenerator> createState() => _GifGeneratorState();
}

class _GifGeneratorState extends State<GifGenerator> {
  String query = "Hello";

  Future<GifGeneratorModel>? _futureGifs;
  TextEditingController _gifTopicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureGifs = _getData();
  }

  Future<GifGeneratorModel> _getData() async {
    Uri url = Uri.parse(
        "https://api.giphy.com/v1/gifs/search?api_key=z7bRjnLtXOhGZUuVicHPH7hceAG6UyTl&q=${query}&offset=0&rating=g&lang=en&bundle=messaging_non_clips");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return welcomeFromJson(response.body);
    } else {
      throw Exception('Failed to load GIFs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<GifGeneratorModel>(
              future: _futureGifs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                  return Center(child: Text('No GIFs found'));
                } else {
                  final gifs = snapshot.data?.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    itemCount: gifs?.length,
                    itemBuilder: (context, index) {
                      final gif = gifs?[index];
                      return OpenContainer(
                        transitionType: ContainerTransitionType.fadeThrough,
                        openElevation: 20.0,
                        openShape: CircleBorder(),
                        transitionDuration: Duration(seconds: 1),
                        closedBuilder: (context, action) => GestureDetector(
                          onTap: action,
                          child: Card(
                            elevation: 2,
                            child: CachedNetworkImage(
                              imageUrl: gif!.images!.fixedHeight!.url!,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        openBuilder: (context, action) => Scaffold(
                          appBar: AppBar(
                            title: Text(gif!.title!),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          ),
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: gif.images!.fixedHeight!.url!,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    downloadGif(gif.images!.original!.url!, 'gif_${gif.title}.gif');
                                    Navigator.pop(context);
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [Text("Download"), Icon(Icons.download)],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _gifTopicController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Cars",
                    prefixIcon: Icon(Icons.card_giftcard, color: Theme.of(context).colorScheme.primary),
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelText: 'GIF Topic',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  cursorColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  query = _gifTopicController.text;
                  _futureGifs = _getData();
                  setState(() {});
                },
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> downloadGif(String url, String fileName) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      // Use File Picker to allow the user to select a directory
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final path = '$selectedDirectory/$fileName';

        try {
          await Dio().download(url, path);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $fileName to $path')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download $fileName')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No directory selected')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  void showGifBottomSheet(BuildContext context, List<Datum> gifs) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: gifs.length,
          itemBuilder: (context, index) {
            final gif = gifs[index];
            return GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Download Gif"),
                  content: CachedNetworkImage(
                    imageUrl: gif.images!.fixedHeight!.url!,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text("Close"), Icon(Icons.close)],
                            )),
                        ElevatedButton(
                          onPressed: () {
                            downloadGif(gif.images!.original!.url!, 'gif_${gif.title}.gif');
                            Navigator.pop(context);
                          },
                          child: const Row(
                            children: [Text("Download"), Icon(Icons.download)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: gif.images!.fixedHeight!.url!,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          },
        );
      },
    );
  }
}
