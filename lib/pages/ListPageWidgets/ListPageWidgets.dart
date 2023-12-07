import 'package:app_project/models/Assignment.dart';
import 'package:flutter/material.dart';
import '../../models/UserSettings.dart';
import '../SettingsPageWidgets/textWidget.dart';
import '../../models/Filters.dart';
import 'package:flutter_html/flutter_html.dart';

UserSettings userSettings = UserSettings(1);

class SearchFilterWidget extends StatefulWidget {
  final Function(String) applySearch;
  final Function(Filters) applyFilters;

  const SearchFilterWidget({
    super.key,
    required this.applySearch,
    required this.applyFilters,
  });

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final searchTextController = TextEditingController();
  final startDateTextController = TextEditingController();
  final endDateTextController = TextEditingController();
  final listFilters = Filters();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  int? _selectedPriority;

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );

    return ExpansionTile(
      title: TextWidget(
        text: "Search/Filter",
        multiplier: 0.8,
      ),
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.search),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search...',
                  ),
                  onChanged: (_) => setState(() {
                    widget.applySearch(searchTextController.text);
                  }),
                ),
              ),
              SizedBox(
                width: 5,
              ),

              IconButton(
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: theme.colorScheme.primaryContainer,
                          elevation: 20,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "Filters",
                                  style: style.apply(
                                      fontSizeFactor:
                                          UserSettings.getFontSize() / 27,
                                      fontWeightDelta: 2),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: "Date Range: ",
                                      multiplier: 0.8,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: _selectedStartDate ??
                                                DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null &&
                                              pickedDate !=
                                                  _selectedStartDate) {
                                            setState(() {
                                              _selectedStartDate = pickedDate;
                                              listFilters.startDate =
                                                  pickedDate;
                                              widget.applyFilters(listFilters);
                                              startDateTextController.text =
                                                  _selectedStartDate != null
                                                      ? _selectedStartDate!
                                                          .toLocal()
                                                          .toString()
                                                          .split(' ')[0]
                                                      : '';
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextField(
                                            controller: startDateTextController,
                                            style: TextStyle(
                                                fontSize:
                                                    UserSettings.getFontSize() *
                                                        0.8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextWidget(
                                      text: " to ",
                                      multiplier: 0.7,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: _selectedEndDate ??
                                                DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null &&
                                              pickedDate != _selectedEndDate) {
                                            setState(() {
                                              _selectedEndDate = pickedDate;
                                              listFilters.endDate =
                                                  pickedDate;
                                              widget.applyFilters(listFilters);
                                              endDateTextController.text =
                                                  _selectedEndDate != null
                                                      ? _selectedEndDate!
                                                          .toLocal()
                                                          .toString()
                                                          .split(' ')[0]
                                                      : '';
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextField(
                                            controller: endDateTextController,
                                            style: TextStyle(
                                                fontSize:
                                                    UserSettings.getFontSize() *
                                                        0.8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  children: [
                                    TextWidget(
                                      text: "Priority: ",
                                      multiplier: 0.8,
                                    ),
                                    DropdownButton<int>(
                                      value: _selectedPriority,
                                      elevation: 100,
                                      items: List.generate(
                                        5,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(
                                            '${index + 1} ${_priorityText(index)}',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          _selectedPriority = newValue!;
                                          listFilters.maxPriority = newValue;
                                          listFilters.minPriority = newValue;
                                          widget.applyFilters(listFilters);
                                        });
                                      },
                                    ),
                                  ]
                                ),
                                SizedBox(
                                  height: 40,
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      listFilters.reset();
                                      widget.applyFilters(listFilters);
                                      startDateTextController.clear();
                                      endDateTextController.clear();
                                      _selectedPriority = null;
                                    });
                                  },
                                  child: TextWidget(
                                    text: "Reset",
                                    multiplier: 0.7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                },
                icon: Icon(Icons.filter_list),
              ),

              // IconButton(
              //   // onPressed: showDialog(
              //   //   context: context,
              //   //   builder:
              //   // ),
              //   // onPressed: () => setState(() {
              //   //   //print("may make this one do something different");
              //   //   // var temp = Filters();
              //   //   // temp.startDate = DateTime.parse("2023-12-14 16:00:00Z");
              //   //   // widget.applyFilters(temp);
              //   // }),
              //   icon: Icon(Icons.filter_list),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class AssignmentWidget extends StatelessWidget {
  const AssignmentWidget({
    super.key,
    required this.assignment,
    required this.selectScreen,
  });

  final Assignment assignment;
  final Function(dynamic) selectScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );

    return Card(
      color: theme.colorScheme.background,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            assignment.name,
            style: style.apply(
                fontSizeFactor: UserSettings.getFontSize() / 27,
                fontWeightDelta: 2),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: PriorityWidget(priority: assignment.priority),
          ),
          // TextWidget(text: "priority", multiplier: 0.7,),
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Flexible(
                    child: assignment.details.startsWith('<')
                        ? Html(
                            data: assignment.details,
                            style: {
                              'body': Style(
                                fontSize:
                                    FontSize(UserSettings.getFontSize() * 0.7),
                                height: Height(
                                    UserSettings.getFontSize() * 0.7 * 5),
                              )
                            },
                          )
                        : Text(
                            assignment.details,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            softWrap: false,
                            style: TextStyle(
                                fontSize: UserSettings.getFontSize() * 0.7),
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => {selectScreen(assignment)},
                    child: TextWidget(
                      text: "View",
                      multiplier: 0.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _priorityText(int priority) {
  switch (priority) {
    case 0:
      return ' (Optional)';
    case 1:
      return ' (Minor)';
    case 2:
      return ' (Medium)';
    case 3:
      return ' (Important)';
    case 4:
      return ' (Urgent)';
    default:
      return '';
  }
}

class PriorityWidget extends StatelessWidget {
  final int priority;

  const PriorityWidget({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    String priorityStr;
    Color priorityColor;

    switch (priority) {
      case 0:
        priorityStr = "Priority 1: Optional";
        priorityColor = const Color.fromARGB(255, 0, 255, 8);
        break;
      case 1:
        priorityStr = "Priority 2: Minor";
        priorityColor = Color.fromARGB(255, 166, 255, 0);
        break;
      case 2:
        priorityStr = "Priority 3: Medium";
        priorityColor = Color.fromARGB(255, 251, 255, 0);
        break;
      case 3:
        priorityStr = "Priority 4: Important";
        priorityColor = Color.fromARGB(255, 255, 166, 0);
        break;
      case 4:
        priorityStr = "Priority 5: Urgent";
        priorityColor = Color.fromARGB(255, 255, 0, 0);
        break;
      default:
        priorityStr = "N/A";
        priorityColor = Color.fromARGB(255, 158, 158, 158);
        break;
    }

    return Text(priorityStr,
        style: TextStyle(
          background: Paint()..color = priorityColor,
          color: priorityColor.computeLuminance() < 0.5
              ? Colors.white
              : Colors.black,
          fontSize: UserSettings.getFontSize() * .7,
        ));
  }
}
