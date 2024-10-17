import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import '../widgets/add_dialog.dart';
import '../widgets/sorting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context, listen: false);
    provider.getUsersAndSort("All");
    return Scaffold(
      appBar: AppBar(
        title: Text("User Data",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),),centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5,
                shadowColor: Colors.grey[800],

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 4)
                        )
                      ]
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search by name...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: (value) {
                        provider.search(value);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SortingDialogue(
                          currentSortOption: provider.selectedSortOption,
                          onSelected: (sort) {
                            provider.getUsersAndSort(sort);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Users Lists',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<UserController>(
                builder: (context, value, child) => value.isloading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: value.searchlist.isEmpty
                            ? value.allUsers.length
                            : value.searchlist.length,
                        itemBuilder: (context, index) {
                          final user = value.searchlist.isEmpty
                              ? value.allUsers[index]
                              : value.searchlist[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              
                            ),elevation: 3,
                            shadowColor: Colors.grey[500],
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    user.image != null ? user.image! : ""),
                                child: user.image == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(
                                user.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Age: ${user.age}",
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddUserWidget(),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
