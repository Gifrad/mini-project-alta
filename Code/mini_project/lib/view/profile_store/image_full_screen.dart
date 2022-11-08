import 'package:flutter/material.dart';
import 'package:mini_project/utils/utils.dart';

class ImageFull extends StatefulWidget {
  final dynamic data;
  const ImageFull({super.key, this.data});

  @override
  State<ImageFull> createState() => _ImageFullState();
}

class _ImageFullState extends State<ImageFull> {
  bool isFull = false;
  final customColor = ColorCustom();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Dialog(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: isFull
                  ? MediaQuery.of(context).size.width * 1
                  : MediaQuery.of(context).size.width * 0,
              height: isFull
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data),
                      fit: isFull ? BoxFit.fitWidth : BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 50,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: FloatingActionButton.extended(
              backgroundColor: customColor.bluePrimary,
              onPressed: () {
                setState(() {
                  isFull = !isFull;
                });
              },
              label: const Text('Perbesar Gambar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
