import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  final _formKey = GlobalKey<FormState>();

  AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creating User'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text("Enter User Data", style: TextStyle(fontSize: 30, color: Colors.blueGrey),),

                const SizedBox(height: 30,),

                TextFormField(
                  controller: controller.idController,
                  decoration: const InputDecoration(
                      label: Text("id"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'please enter id';
                    }
                  },
                  onSaved: (value) {
                    controller.id = value;
                  },

                ),
                const SizedBox(height: 25,),

                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'please enter name';
                    }
                  },
                  onSaved: (value) {
                    controller.name = value;
                  },
                ),

                const SizedBox(height: 25,),

                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'please enter email';
                    }
                  },
                  onSaved: (value) {
                    controller.email = value;
                  },
                ),

                const SizedBox(height: 25,),

                TextFormField(
                  controller: controller.ageController,
                  decoration: const InputDecoration(
                      label: Text("Age"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'please enter age';
                    }
                  },
                  onSaved: (value) {
                    controller.age = value;
                  },
                ),

                const SizedBox(height: 20,),

                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    controller.insertUserDetails();
                  }
                }, child: const Text("Submit"))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
