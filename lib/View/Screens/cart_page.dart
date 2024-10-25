import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/global.dart';
import '../Component/dialogBox.dart';
import 'home_page.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Cart'),),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.userInfoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  tileColor:
                      HomeScreenColorlist[index % HomeScreenColorlist.length],
                  title: Text(controller.userInfoList[index].name!),
                  subtitle: Text(controller.userInfoList[index].email!),
                  leading: Text(controller.userInfoList[index].id.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => updateDataDialog(
                                  w,
                                  h,
                                  controller,
                                  index,
                                  controller.userInfoList[index].id),
                            );
                          },
                          icon: Icon(Icons.edit)),
                      Text(controller.userInfoList[index].phone!.toString()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
