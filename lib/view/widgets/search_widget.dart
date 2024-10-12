import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controller/home_controller.dart';
import 'popup_widget.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                Provider.of<HomeController>(context, listen: false)
                    .searchUsers(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: Colors.grey,
                ),
                hintText: 'Search by name',
                hintStyle: GoogleFonts.montserrat(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Consumer<HomeController>(
            builder: (context, homeController, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  homeController.setFilter(value);
                },
                itemBuilder: (context) => [
                  buildPopupMenuItem('all', 'All', context),
                  buildPopupMenuItem('elder', 'Elder', context),
                  buildPopupMenuItem('younger', 'Younger', context),
                ],
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}