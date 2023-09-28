import 'package:adminm/maduls/video_screen/create_video_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCoursesScreen extends StatefulWidget {
  final name;
  const ListCoursesScreen({Key? key,this.name}) : super(key: key);

  @override
  State<ListCoursesScreen> createState() => _ListCoursesScreenState();
}

class _ListCoursesScreenState extends State<ListCoursesScreen> {

  @override
  Widget build(BuildContext context) {
    CollectionReference courses = FirebaseFirestore.instance.collection(widget.name);
    return Scaffold(
      body:  Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/img.png',),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('DR/ Mohamed Yasser',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Courses',style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),),
                const SizedBox(
                  height: 30,
                ),
                Expanded(child: Container(
                  child: FutureBuilder(
                    future: courses.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateVideoScreen(
                                    videoname: widget.name,
                                    docid: snapshot.data!.docs[i].id,
                                  )));
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          // height: double.infinity,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(50),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/logo.jpeg',
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 180,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    (snapshot.data!.docs[i].data() as Map)['name'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                    TextDirection.rtl,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),),
              ],
            ),
          ),
          const Text(
            'Create by : 3M Technology, Contact: 01146039990'
            ,style: TextStyle(
            color: Colors.black,
          ),
          ),
        ],
      ),
    );
  }
}
