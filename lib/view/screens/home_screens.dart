import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool isLoadingMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Nilambur",
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        leading: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.logout, color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.grey,
                    ),
                    hintText: "Search by Name",
                    hintStyle: GoogleFonts.montserrat(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                ),
                
                SizedBox(height: 20),
                Text('Users Lists',style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.grey[500])),
                  SizedBox(height: 10),
                  Expanded(child: Consumer<HomeController>(builder: (context, homeController, child) {
                    return RefreshIndicator(
                       onRefresh: (){
                      return  homeController.refreshUsers();
                       },
                      child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if(
                          notification is ScrollEndNotification && 
                          notification.metrics.extentAfter == 0 && !homeController.isLoading && homeController.hasMore
                        ){
                          homeController.loadMore();
                        }
                        return false;
                      },child: ListView.builder(
                        // controller:,
                        itemCount: homeController.filteredUsers.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == homeController.filteredUsers.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final user = homeController.filteredUsers[index];
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundImage: user.image != null ? NetworkImage(user.image!):const AssetImage("assets/person.png") as ImageProvider,
                              ),
                              title: Text(user.name ?? ''),
                              subtitle: Text(user.age ?? ''),
                            ),
                          );
                        },
                      ),
                    ),
                  ); 
                }
              ),
            ),
          ]
        )
      )
    );
  }          
}
    