import 'package:flutter/material.dart';
import 'package:flutter_pro/dbHelper.dart';
import 'package:flutter_pro/task.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:intl/intl.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      
      home: Home(),
        
    );
  }
}

class Home  extends StatefulWidget {
 
  @override
  _HomeState  createState() => _HomeState();
  
}


class _HomeState extends State < Home > {
  
  late int val ;
  late String name ; 
   String ? dueDate ;
  DateTime date = DateTime.now();
  DateTime date_task = DateTime.now() ;
  late String date_str ;
  late DbHelper helper  ;
  bool flag = false ;
  FontWeight fw = FontWeight.bold ;
  

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
    toolbarHeight: 200, 
    flexibleSpace: Container(
       child : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:25.0 , left: 20),
                      child: Row( 
                        
                        children: <Widget>[
                          Icon(Icons.menu , color: Colors.white ,size: 35 ,),
                          SizedBox( width: 25,),
              
                        Text('Tasker',
                        style: TextStyle(
                          fontWeight: FontWeight.bold , fontSize: 40 , color: Colors.white ,
                        ),
                        ),
                        ],
                        ),
                    ),
                    SizedBox(height: 75,),

                    Padding(
                      padding: const EdgeInsets.only( right: 20 , left: 20),
                      child: Row(
                        
                        children: <Widget>[
                          Text('${date.day}',
                          style: TextStyle(
                          fontWeight: FontWeight.w500 , fontSize: 50 , color: Colors.white ,
                        ),
                        ),
                        SizedBox(width: 5,),


                        Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${DateFormat('MMM').format(date)}',
                            style: TextStyle(
                          fontWeight: FontWeight.w500 , fontSize: 15 , color: Colors.white ,
                        ),
                        ),
                        Text('${date.year}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500 , fontSize: 15 , color: Colors.white ,
                        ),
                        ),

                        ],
                        ),
                        SizedBox(width: 162,),


                        Text('${DateFormat('EEEE').format(date)}',
                          style: TextStyle(
                           fontSize: 18 , color: Colors.white ,
                        ),
                        ),
                        ],
                        ),
                    ),
                    
                  ],
                  ),
              ),
              ),
              floatingActionButton :FloatingActionButton (
                  heroTag: UniqueKey(),
                  onPressed: (){

                   showModalBottomSheet  <dynamic> (

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),

                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext bc) {
                      return 
                        
                       Padding(
                         padding: MediaQuery.of(context).viewInsets ,
                         child: Wrap(
                              children: <Widget>[
                       
                                Padding(
                                  padding: const EdgeInsets.only(top: 15 , right: 20 , left: 20),

                                  child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Task'
                                      ),
                                      
                                      validator: (value) {
                                        if (value == null || value.isEmpty){
                                          return 'Task name is Required' ;
                                        }
                                      },
                                      onChanged: (value) {
                                        name = value ;
                                      },
                                      ),
                                ),
                       
                       
                                    SizedBox(height: 30,),
                       
                       
                                     Padding(
                                       padding: const EdgeInsets.only( right: 20 , left: 20),
                                    
                                       child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'No due data'
                                                 ),
                                          onChanged: (value) {
                                            dueDate = value ;
                                            
                                    },
                                    validator: (value) {
                                      if (value == null )
                                      value = '' ;
                                      dueDate = value ;
                                      
                                    },
                                              ),
                                     ),
                                     
                       
                       
                                    SizedBox(height: 60,),
                       
                       
                                    Padding(
                                      padding: const EdgeInsets.only(left : 20 ,),
                                      child: Row(
                                        children: <Widget>[
                       
                       
                                          IconButton(

                                            icon: Icon(Icons.calendar_today_outlined , size:  30 , color: Colors.blue,),

                                            onPressed: () async{
                                             DateTime ?  newDate = await showDatePicker(
                                                context: context, 
                                                initialDate: date,
                                                 firstDate: date ,
                                                  lastDate: DateTime(2100),
                                                  );
                                                  if(newDate == null) {
                                                    return ;
                                                  }
                                                 
                                                    setState(() {
                                                      date_task = newDate ;
                                                      date_str = DateFormat.yMd().format(date_task);
					  
                                                    });
                                                  
                                          },
                                          
                                          ),
                                            
                       
                       
                                            Text('${date_task.day}/${date_task.month}/${date_task.year}' , 
                                            style: TextStyle(fontSize: 15),
                                            ),
                       
                                            SizedBox( width: 65,),
                       
                       
                                          TextButton(
                                           child: Text('cancel' ,
                                           style: TextStyle(
                                            fontSize: 20 , fontWeight: FontWeight.bold  , color: Colors.black,
                                           ),
                                           ),
                                           onPressed: (){
                                            Navigator.of(context).pop() ;
                                           },
                                           ),
                       
                                            SizedBox( width: 25,),
                       
                       
                                          TextButton(
                       
                                            child: Text('Save' ,
                                           style: TextStyle(
                                            fontSize: 20 , color: Colors.blue ,fontWeight: FontWeight.bold ,
                                           ),
                                           ),
                       
                                            onPressed: ()async{
                                              Task task = Task({'name': name , 'due_date' : dueDate , 'date' : date_str }); 
                                              int id = await helper.createTask(task);
                                              Navigator.of(context).pop() ;

                                              setState(() {
                                                date_task = date ;
                                              });
                                            },
                                            
                                           ),
                       
                                           SizedBox(height: 100,),
                                      ],
                                      ),
                                    ),
                              ]
                          ),
                       );
                      
                    }
                    );
                  },
                  child: Icon(Icons.add , size: 25 , color:  Colors.white,),
                  ),

              body: FutureBuilder(
                 future: helper.allTasks(),
                builder: ((context,
                AsyncSnapshot snapshot) {
                  if (! snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  else {
                    return ListView.builder(
                      itemCount: snapshot.data.length ,
                      itemBuilder: (context , index){
                        Task task = Task.fromMap(snapshot.data[index]);
                        

                        return ListTile(
                       leading:
                        RoundCheckBox(
                        onTap: (selected) {
                          fw = FontWeight.normal ;
                        },
                        size: 45 ,
                        checkedWidget: Icon(Icons.check, color: Colors.white ,size: 35,),
                        checkedColor: Colors.blue,
                         borderColor: Colors.blue ,
                        ),
                      
                          title: Text('${task.name} ${task.date} ', 
                          style: TextStyle(
                            fontWeight: fw ,
                          ), 
                            
                          ),

                        subtitle: Text(task.dueDate ?? '' , 
                        style: TextStyle(
                          color: Colors.grey ,
                        ),
                        ) ,
                        trailing: IconButton(
                          icon: Icon(Icons.delete , color: Colors.red, size: 20,), 
                          onPressed: (){
                            setState(() {
                              if (task.id !=null){
                                helper.delete(task.id??-1);
                              }
                            });
                          },
                         ),
                         onTap: () {},
                        );

                      }
                      );
                  }
                })
                ),

    );

  }
  
  }
  

  
	