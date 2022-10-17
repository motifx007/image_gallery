import 'package:flutter/material.dart';
import 'package:image_gallery/helpers/image_list.dart';
import '../utils/device_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _scaffoldBody(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Image Gallery'),
    );
  }

  Widget _scaffoldBody() {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: imageList.length,
          gridDelegate: _gridDelegate(orientation),
          itemBuilder: (context, index) {
            return InkWell(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(details.globalPosition, imageList[index]);
              },
              child: _gridViewItem(index),
            );
          });
    });
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate(
      Orientation orientation) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: orientation == Orientation.portrait
          ? 2
          : getDeviceType() == DeviceType.phone
              ? 3
              : 4,
    );
  }

  Padding _gridViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageList[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showPopupMenu(Offset offset, String imageUrl) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, left, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: Colors.white.withAlpha(230),
      items: [
        PopupMenuItem<String>(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          height: 24,
          value: imageUrl,
          enabled: true,
          child: Text(
            imageUrl,
          ),
        ),
      ],
      elevation: 2.0,
    );
  }
}
