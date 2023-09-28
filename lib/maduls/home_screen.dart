import 'package:adminm/maduls/code_screen/code_courses_screen.dart';
import 'package:adminm/maduls/video_screen/courses_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: const Image(image: AssetImage('assets/images/logo.jpeg',),
              fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 500,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container(
                    height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                          color: Colors.white30
                      ),
                      child: TextButton(
                        onPressed: ()  {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const VideoCoursesScreen()));
                        },
                        child: Text(
                          "Create Video",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                  ),),
                  const SizedBox(width: 50,),
                  Expanded(child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                          color: Colors.white30
                      ),
                      child: TextButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const CodeCoursesScreen()));

                        },
                        child: Text(
                          "Create Code",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                  )),

                ],
              ),
            ),
          ],
        ),
    );
  }
}
