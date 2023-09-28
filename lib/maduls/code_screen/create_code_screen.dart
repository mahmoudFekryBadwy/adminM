import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateCodeScreen extends StatefulWidget {
  final docid;
  final namecode;
  const CreateCodeScreen({Key? key,this.docid,this.namecode}) : super(key: key);

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  bool isloading = false;
  var _controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  var codevideo;

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    CollectionReference coderef = FirebaseFirestore.instance.collection(widget.namecode).doc(widget.docid).collection("codes");
    deletCode(String uId){
      coderef.doc(uId).delete().then((value) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Done',
          desc: 'Successful',
          btnOkOnPress: () {},
        ).show();
      }
      ).catchError((e){
        AwesomeDialog(
            context: context,
            title: "Done",
            body:  Text(e.toString()))
            .show();
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter The New Code',style: TextStyle(
            fontSize: 25
        ),),
      ),
      body: Container(
        child: Form(
          key: formstate,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _controller,
                  onSaved: (val) {
                    codevideo = val;
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
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Code Video",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))),
                ),
              ),
              const SizedBox(height: 30,),
              if(isloading)
                const CircularProgressIndicator(),
              if(!isloading)
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              var formdata = formstate.currentState;
                              if (formdata!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                formdata.save();
                                await FirebaseFirestore.instance
                                    .collection(widget.namecode)
                                    .doc(widget.docid)
                                    .collection("codes")
                                    .add({
                                  "code":codevideo,
                                  "uid": FirebaseFirestore.instance.collection(widget.namecode).doc(widget.docid).collection("codes").doc().id,
                                });
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Done',
                                  desc: 'Successful',
                                  btnOkOnPress: () {},
                                ).show();
                                _controller.clear();
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
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isloading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection(widget.namecode)
                                  .doc(widget.docid)
                                  .collection("codes")
                                  .add({
                                "code":getRandomString(8),
                                "uid": FirebaseFirestore.instance.collection(widget.namecode).doc(widget.docid).collection("codes").doc().id,

                              });
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Done',
                                desc: 'Successful',
                                btnOkOnPress: () {},
                              ).show();
                              _controller.clear();
                              setState(() {
                                isloading = false;
                              });


                            },
                            child: Text(
                              "Auto Code",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30,),
              const Text('اكواد المحاضرة',style: TextStyle(
                  fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: coderef.snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,i){
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children:  [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:  [
                                              Row(
                                                children: [
                                                  const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                                                    child: Text("code :",style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),),
                                                  ),),
                                                  Expanded(child: Center
                                                    (child: Padding(padding: const EdgeInsets.only(top: 0),
                                                    child: SelectableText((snapshot.data!.docs[i].data() as Map)['code'],
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),),),
                                                  Expanded(
                                                    child: Padding(padding: const EdgeInsets.only(left: 20),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          deletCode(snapshot.data!.docs[i].id);
                                                        },
                                                        child: const Text("delete",style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                        ),),
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      }
                      if(snapshot.hasError){
                        return const Text('Error');
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    },),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
