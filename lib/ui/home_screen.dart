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
                showMyDialog(index);
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

  showMyDialog(int index) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        title: const Text("Image Url"),
        content: Wrap(
          children: [
            Text(imageList[index]),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Okay",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
