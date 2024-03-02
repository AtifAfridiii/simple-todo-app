
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo/firestore/add_firestore_data.dart';
import 'package:todo/postScreen/addpost.dart';
import 'package:todo/uiis/login.dart';
import 'package:todo/utilis/toastmessage.dart';
import 'package:gap/gap.dart';

class Post_Screen extends StatefulWidget {
  const Post_Screen({super.key});

  @override
  State<Post_Screen> createState() => _Post_ScreenState();
}

final auth =FirebaseAuth.instance;
final ref = FirebaseDatabase.instance.ref('Data');
final controller = TextEditingController();
final text_field_Controller = TextEditingController();

class _Post_ScreenState extends State<Post_Screen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        width: 201,
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
     const DrawerHeader(
         margin: EdgeInsets.only(bottom: 51),
        decoration: BoxDecoration(
          color: Colors.deepPurple,

        ),
        child: ListTile(
          leading: CircleAvatar(
    
            backgroundImage: NetworkImage('https://images.pexels.com/photos/7869249/pexels-photo-7869249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',)
           
          ),
          title:Text("Atif Afridi",style: TextStyle(color: Colors.white),),
          subtitle:Text( 'atifafridi@gmail.com',style: TextStyle(color: Colors.black),),
        ),
      ),
      ListTile(
        title: const Text('Log out'),
        trailing:IconButton(onPressed: (){
      auth.signOut().then((value) {
         Utilis().ToastMessage('Log out');
      }).onError((error, stackTrace) {
        Utilis().ToastMessage(error.toString());
      }); 
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Log_In(),));
    }, icon:const  Icon(Icons.logout,color: Colors.black,)),
      ),
      ListTile(
        title:const  Text('Home'),
        trailing: const Icon(Icons.home),
        onTap: () {
          // Handle item 2 tap
          Navigator.pop(context); // Close the drawer
        },
      ),
    ],
  ),
)
,
    appBar: AppBar(title: const Text('post screen',style: TextStyle(color: Colors.white),),
    centerTitle: true,
    automaticallyImplyLeading: false,
    actions: [
    const SizedBox(width: 11,),
    
    const Gap(5),
     IconButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Firestore_Screen()));
     }, icon: const Icon(Icons.skip_next,color:Colors.white ,)),
    ],
    ),

    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
     
        // Expanded(
        //   child: FirebaseAnimatedList(
        //     query: ref, 
        //      itemBuilder: (BuildContext context, snapshot, animation,index){
        //       return ListTile(
        //           title: Text(snapshot.child('Title').value.toString()),
        //           subtitle: Text(snapshot.child('id').value.toString()),
        //       );
        //      },),
        // ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
               child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                   hintFadeDuration: const Duration(seconds: 3),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(51)),
                  prefixIcon:const Icon(Icons.search_rounded),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(51),
                    borderSide:const  BorderSide(
                      color: Colors.pink,
                     style: BorderStyle.solid,
                     
                    ),
                   
                   ),

                ),
             onChanged: (value){
               setState(() {
                 
               });
             },
               ),
             ),
      Expanded(
        child: StreamBuilder(
          stream: ref.onValue,
         builder:(context , AsyncSnapshot <DatabaseEvent> snapshot){
        
          if(snapshot.hasData && snapshot.data != null && snapshot.data!.snapshot.value != null){
        
            Map<dynamic,dynamic>map = snapshot.data!.snapshot.value as dynamic;
            List<dynamic> list = [];
            list.clear();
            list=map.values.toList();
           
        
          return ListView.builder(
          itemCount:snapshot.data!.snapshot.children.length,
          itemBuilder: (context,index){
           final Title = list[index]['Title'].toString();
           if(Title.isEmpty){
             return Card(
              shadowColor: Colors.black,
           
               child: ListTile(
               title: Text(list[index]['Title'].toString()),
               subtitle:Text(list[index]['id'].toString()),
                trailing:PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context)=>[
                           PopupMenuItem(
                    
                      value: 1,
                      child: ListTile( 
                        onTap: (){
                         
                          showmydialouge(Title,list[index]['id'].toString());
                          Navigator.pop(context);
                        },
               
                      title: const Text('Edit'),
                      leading:const Icon(Icons.edit),
                      
                    )),
                     PopupMenuItem(
                      value: 2,
                      child: ListTile(
                         onTap: (){
                          Navigator.pop(context);
                          ref.child(list[index]['id'].toString()).remove();
                        },
                      title:const Text('Delete'),
                      leading: const Icon(Icons.delete),
                    ))
                  ],
                ),
                          ),
             );
           }else if (Title.toLowerCase().contains(controller.text.toLowerCase().toString())){
 return Card(
  shadowColor: Colors.black,

   child: ListTile(
   title: Text(list[index]['Title'].toString()),
   subtitle:Text(list[index]['id'].toString()),
   trailing:PopupMenuButton(
                  icon:const  Icon(Icons.more_vert),
                  itemBuilder: (context)=>[
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: (){
                        Navigator.pop(context);
                        showmydialouge(Title,list[index]['id'].toString());
                        },
                      title: const Text('Edit'),
                      leading: const Icon(Icons.edit),
                    )),
                     PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          ref.child(list[index]['id'].toString()).remove();
                        },
                      title: const Text('Delete'),
                      leading: const Icon(Icons.delete),
                    )),
                  ]
                
              )),
 );
           }else{
   return Container();
           }
            
           
         });
        
          }else{ 
        return const CircularProgressIndicator(color: Colors.white,);
          }
               } ),
      )

      ],
    ),
    floatingActionButton: FloatingActionButton(onPressed: (){
 Navigator.push(context, MaterialPageRoute(builder: (context) =>const Add_post(),));
    },
    backgroundColor: Colors.red,
    focusColor: Colors.deepPurple,
    child: const Icon(Icons.add),),
    );
  }
 Future<void> showmydialouge(String Title,String id)async{
  text_field_Controller.text=Title;

return showDialog(
  context: context, 
builder: (BuildContext context ,){
  return AlertDialog(
    title: const Text('Update'),
    content: TextField(
      controller:text_field_Controller ,
      decoration:const  InputDecoration(
        hintText: "Edit",
      ),
    
    ),
    actions: [
      TextButton(onPressed: (){
          Navigator.pop(context);
      }, child: const Text('Cancle')),

   TextButton(onPressed: (){
     Navigator.pop(context);
    ref.child(id).update({
    'Title' : text_field_Controller.text.toString(),
    });
   }, child:const  Text('Update'))
    ],
  );
});



  }
}