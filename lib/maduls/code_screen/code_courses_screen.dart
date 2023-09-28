import 'package:adminm/maduls/code_screen/list_code_video_screen.dart';
import 'package:adminm/maduls/video_screen/list_courses_screen.dart';
import 'package:flutter/material.dart';

class CodeCoursesScreen extends StatefulWidget {
  const CodeCoursesScreen({Key? key}) : super(key: key);

  @override
  State<CodeCoursesScreen> createState() => _CodeCoursesScreenState();
}

class _CodeCoursesScreenState extends State<CodeCoursesScreen> {
  @override
  Widget build(BuildContext context) {
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
                SingleChildScrollView(
                  child: Container(
                    child:Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ListCodeVideoScreen(
                              name: "courses2",
                            )));
                          },
                          child: Card(
                            color: Colors.grey.shade300,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              child: Row(
                                children:  [
                                  Container(
                                    // height: double.infinity,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/logo.jpeg',),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 180,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  const [
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Text('الفرقة الثانية',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23,
                                              ),
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ListCodeVideoScreen(
                              name: "courses3",
                            )));
                          },
                          child: Card(
                            color: Colors.grey.shade300,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              child: Row(
                                children:  [
                                  Container(
                                    // height: double.infinity,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/logo.jpeg',),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 180,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  const [
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Text('الفرقة الثالثة',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23,
                                              ),
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
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
                        ),
                      ],
                    ),
                  ),
                ),
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
