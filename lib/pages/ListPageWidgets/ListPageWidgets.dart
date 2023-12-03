import 'package:app_project/models/Assignment.dart';
import 'package:flutter/material.dart';
import '../../models/UserSettings.dart';
import '../SettingsPageWidgets/textWidget.dart';
UserSettings userSettings = UserSettings(1);
class SearchFilterWidget extends StatefulWidget {
  final Function(String) applyFilter;

  const SearchFilterWidget({
    super.key,
    required this.applyFilter,
  });
  
  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {

  final textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextWidget(text: "Search/Filter", multiplier: 0.8,),
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
                  controller: textFieldController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search...',
                  ),
                  onChanged: (_) => setState(() {
                    widget.applyFilter(textFieldController.text);
                  }),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () => setState(() {
                  widget.applyFilter(textFieldController.text);
                  print("may make this one do something different");
                }),
                icon: Icon(Icons.filter_list),
              ),
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
            style: style.apply(fontSizeFactor: UserSettings.getFontSize() / 27, fontWeightDelta: 2),
          ),
          subtitle: TextWidget(text: "priority", multiplier: 0.7,),
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      assignment.details,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      softWrap: false,
                      style: TextStyle(fontSize: UserSettings.getFontSize() * 0.7),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => {selectScreen(assignment)},
                      child: TextWidget(text: "View", multiplier: 0.7,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
