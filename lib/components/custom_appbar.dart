import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/components/colors.dart';
import '../Service/data_service.dart';
import '../models/Trophy.dart';
import '../models/Match.dart';
import '../screens/bottom_sheet.dart';
import '../screens/searchScreeen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(Trophy) onTrophySelected;
  final Function() onNotifPressed;
  final Function(String) onSearchQueryChanged;
  final Function() onSearchClosed;
  final List<Match> allMatches; // Pass matches to search screen
  final int notifCount;

  const CustomAppBar({
    Key? key,
    required this.onTrophySelected,
    required this.onNotifPressed,
    required this.onSearchQueryChanged,
    required this.onSearchClosed,
    required this.allMatches,
    required this.notifCount,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // Fixed height for the AppBar
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode(); // FocusNode to handle keyboard events

  final DataService dataService = DataService();
  List<Trophy> trophiesList = [];

  Future<void> _fetchTrophies() async {
    final fetchedTrophies = await dataService.fetchTrophies();
    setState(() {
      trophiesList = fetchedTrophies;
      trophiesList.sort((a, b) => a.name!.compareTo(b.name!));
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchTrophies();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Add listener to close search when keyboard is dismissed
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isSearching = false; // Close search bar
          _searchController.clear(); // Clear search field
          widget.onSearchClosed(); // Notify that search is closed
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose(); // Dispose of FocusNode
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: _scaffoldkey,
      // Ensure no drawer icon is present
      // actions: [
      //   IconButton(
      //     iconSize: 40, // Adjust the icon size as needed
      //     icon: const ImageIcon(
      //       AssetImage("assets/icons/profil.png"),
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Scaffold.of(context).openEndDrawer(); // Open end drawer
      //     },
      //   ),
      // ],
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0), // Optional padding for alignment
          // child: ImageIcon(
          //   AssetImage("assets/icons/profil.png"),
          //   color: Colors.white,
          //   size: 40, // Adjust the size of the icon as needed
          // ),
        ),
      ],
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 4, // Shadow effect for AppBar
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColors.appbarColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.appbarShadow,
              offset: Offset(0, 4),
              blurRadius: 5.9,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.952), // Fixed space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side widgets
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Shadow container
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 27,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.profileIconShadow,
                                  offset: Offset(11, 0), // Shadow only on the bottom
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        // Notification icon
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications, color: Colors.white), // Default notification icon
                              onPressed: () {
                                widget.onNotifPressed();
                              },
                            ),
                            if (widget.notifCount > 0)
                              Positioned(
                                right: 11,
                                top: 11,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 10,
                                    minHeight: 10,
                                  ),
                                  child: Text(
                                    '${widget.notifCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context);
                        },
                        child: Container(
                          width: 69,
                          height: 39,
                          padding: const EdgeInsets.only(right: 1.0),
                          decoration: BoxDecoration(
                            gradient: AppColors.trophyButton,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.trophyBorder, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.trophyShadow,
                                offset: Offset(0, 4),
                                blurRadius: 5.1,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/trophy.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 4),
                              Image.asset(
                                'assets/icons/down.png',
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Right side widgets
                Row(
                  children: <Widget>[
                    // Search bar container
                    AnimatedContainer(
                      duration: _isSearching
                          ? const Duration(milliseconds: 300) // Smooth animation when opening
                          : Duration.zero, // Instant collapse when closing
                      width: _isSearching ? MediaQuery.of(context).size.width * 0.5 : 0, // Set width conditionally based on state
                      height: 45,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: _isSearching
                          ? TextField(
                        controller: _searchController,
                        focusNode: _focusNode, // Add focus node here
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              widget.onSearchQueryChanged(value);
                            }
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Recherche ...',
                          hintStyle: const TextStyle(color: Colors.white54, wordSpacing: 10),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                          prefixIcon: Image.asset(
                            'assets/icons/searchIcon.png',
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _isSearching = false;
                                _searchController.clear();
                                widget.onSearchClosed();
                              });
                            },
                          ),
                        ),
                      )
                          : null,
                    ),

                    // Search icon
                    Visibility(
                      visible: !_isSearching,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/icons/searchIcon.png', // Replace with your custom search icon
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                          _animationController.forward(); // Expand the search bar
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 1.0),
                    //   child: Builder(
                    //     builder: (context) {
                    //       return Stack(
                    //         clipBehavior: Clip.none,
                    //         children: [
                    //           // Shadow container
                    //           Positioned(
                    //             bottom: 0,
                    //             child: Container(
                    //               width: 27,
                    //               height: 4,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.transparent,
                    //                 boxShadow: const [
                    //                   BoxShadow(
                    //                     color: AppColors.profileIconShadow,
                    //                     offset: Offset(12, 0), // Shadow only on the bottom
                    //                     blurRadius: 4,
                    //                     spreadRadius: 0,
                    //                   ),
                    //                 ],
                    //                 borderRadius: BorderRadius.circular(30),
                    //               ),
                    //             ),
                    //           ),
                    //           // Icon container
                    //           Container(
                    //             width: 52,
                    //             height: 52,
                    //             decoration: BoxDecoration(
                    //               color: Colors.transparent, // Background color if needed
                    //               borderRadius: BorderRadius.circular(26), // Same radius as shadow container
                    //             ),
                    //             // child: IconButton(
                    //             //   icon: const Icon(
                    //             //     Icons.more_vert,
                    //             //     color: Colors.white,
                    //             //   ),
                    //             //   onPressed: () {
                    //             //     Scaffold.of(context).openEndDrawer(); // Open end drawer
                    //             //   },
                    //             // ),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // If the content might scroll
      backgroundColor: Colors.transparent, // Optional: to match your design
      builder: (BuildContext context) {
        return BottomSheetContent(
            onTrophySelected: widget.onTrophySelected, trophies: trophiesList);
      },
    );
  }
}
