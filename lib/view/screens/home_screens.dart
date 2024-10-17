import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/home_controller.dart';
import 'package:totalx/view/widgets/floating_widget.dart';

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
  final  ScrollController _scrollController = ScrollController();

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
                onTap: () {
                  // AuthService().signOut();
                },
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
                          _loadMoreLists();
                        }
                        return false;
                      },child: ListView.builder(
                        controller:_scrollController,
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
      ),
      floatingActionButton: FloatingWidget(
        ageController: ageController,
        nameController: nameController,
      ),
    );

  } 



  Future<void> _loadMoreLists()async{
    final homeController = Provider.of<HomeController>(context,listen: false);
    if(!homeController.isLoadingMore && homeController.hasMore){
      await homeController.loadMore();
    }
  }

    void _scrollingListen(){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadMoreLists();
      }
    }

   @override
   void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_scrollingListen);
    _scrollController.dispose();
    super.dispose();
  }       
}
    