import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_string.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'package:offline_database/app/core/values/app_color.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(controller.isAnimating.value ? HomePageStrings.refreshingMessage : HomePageStrings.appBarTitle);
          }),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.fetchData();
                },
                icon: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(controller.animationController),
                    child: const Icon(Icons.refresh)
                ))
          ],
        ),
        body: Obx(() {
          final userDetails = controller.data;

          if (userDetails.isEmpty) {
            return const Center(
                child: Text(HomePageStrings.emptyMessage, style: TextStyle(fontSize: 30),)
            );
          } else {
            return ListView.separated(
              itemCount: userDetails.length,
              itemBuilder: (context, index) {
                final userDetail = userDetails[index];
                return Dismissible(
                  key: Key(userDetail.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: AppColors.redColor,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  onDismissed: (_) {
                    controller.deleteUserDetails(userDetail.id!);
                  },
                  child: ListTile(
                    onLongPress: () {
                      Get.dialog(AlertDialog(
                        title: const Text(HomePageStrings.alertDeleteTitle),
                        content: const Text(
                            HomePageStrings.alertDeleteContent),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text(HomePageStrings.alertCancel),
                          ),
                          TextButton(
                            onPressed: () {
                              // Call delete method here
                              controller.deleteUserDetails(userDetail.id!);
                              userDetails.removeAt(index);
                              Get.back();
                            },
                            child: const Text(HomePageStrings.alertCancel),
                          ),
                        ],
                      ));
                    },
                    leading: Text('${index + 1}'),
                    title: Text(
                        '${userDetail.name!}  (${HomePageStrings.textBeforeId} ${userDetail.id.toString()})'),
                    subtitle: Text(userDetail.email!),
                    trailing: Text('${HomePageStrings.textBeforeAge} ${userDetail.age.toString()}'),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 10,
                );
              },
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_USER);
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
