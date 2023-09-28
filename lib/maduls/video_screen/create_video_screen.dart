
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreateVideoScreen extends StatefulWidget {
  final docid;
  final videoname;
  const CreateVideoScreen({Key? key,this.docid,this.videoname}) : super(key: key);

  @override
  State<CreateVideoScreen> createState() => _CreateVideoScreenState();
}

class _CreateVideoScreenState extends State<CreateVideoScreen> {
  var namevideo, linkvideo ,numbervideo;
  var _namecontroller = TextEditingController();
  var _linkcontroller = TextEditingController();
  var _numbercontroller = TextEditingController();
  bool isloading = false;


  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('add the video'),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formstate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ادخل اسم الفيديو',style: TextStyle(
                        fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _namecontroller,
                      keyboardType: TextInputType.text,
                      onSaved: (val) {
                        namevideo = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 0) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.personal_video),
                          hintText: "Name Video",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(height: 20,),
                    const Text('ادخل لينك الفيديو',style: TextStyle(
                        fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _linkcontroller,
                      keyboardType: TextInputType.url,
                      onSaved: (val) {
                        linkvideo = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.link),
                          hintText: "Link Video",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(height: 20,),
                    const Text('ادخل رقم الفيديو',style: TextStyle(
                        fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _numbercontroller,
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        numbervideo = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 1) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          hintText: "Number Video",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(height: 30,),
                    if(isloading)
                      const CircularProgressIndicator(),
                    if(!isloading)
                      Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              var formdata = formstate.currentState;
                              if (formdata!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                formdata.save();
                                await FirebaseFirestore.instance
                                    .collection(widget.videoname).doc(widget.docid).collection("videos")
                                    .add({"name": namevideo, "video": linkvideo, "num":numbervideo,});
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Done',
                                  desc: 'Successful',
                                  btnOkOnPress: () {},
                                ).show();
                                _namecontroller.clear();
                                _numbercontroller.clear();
                                _linkcontroller.clear();
                              }
                              setState(() {
                                isloading = false;
                              });


                            },
                            child: Text(
                              "Save",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                      )

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
