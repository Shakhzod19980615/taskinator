import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../main.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final titleController = TextEditingController();
  final _titleKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkground,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Edit task", style: TextStyle(fontSize: 20,color: Colors.orange,fontWeight: FontWeight.w500),),
            Spacer(),
            InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage()
                    ),
                  );
                },
                child: Icon(Icons.cancel,color: Colors.orange,))
          ],
        ),
        elevation: 0,
        backgroundColor: bkground,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
              children: [
                Container(
                    alignment: AlignmentDirectional.centerStart,
                    margin: EdgeInsets.only(top: 30,bottom: 10),
                    child: Text("March 27 march")),
                Form(
                  key: _titleKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: TextFormField(
                      controller: titleController,
                      validator: (value){
                        if(value ==null || value.isEmpty ){
                          return 'Please enter title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange )
                          ),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: CupertinoColors.inactiveGray)
                          ),
                          labelText: 'Task title*',
                          labelStyle: TextStyle(color:  Colors.orange)
                      ),
                    ),
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
