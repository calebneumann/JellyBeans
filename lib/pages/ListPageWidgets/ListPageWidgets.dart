import 'package:app_project/models/Assignment.dart';
import 'package:flutter/material.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(""),
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              IconButton(
                onPressed: () => { print("TODO: Search functionality") }, 
                icon: Icon(Icons.search),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search...',
                  ),
                ),
              ),
              SizedBox(width: 5,),
              IconButton(
                onPressed: () => { print("TODO: Filter functionality") }, 
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
  });

  final Assignment assignment;

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
            style: style.apply(fontSizeFactor: 0.7, fontWeightDelta: 2),
          ),
          subtitle: Text("priority"),
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in aliquam eros, a posuere nibh. Nullam in nisl eleifend, bibendum leo at, volutpat nulla. Vestibulum quis nisi felis. Nam a orci congue, facilisis velit vel, posuere est. Ut dolor ante, ultricies a fermentum a, iaculis a leo. Aliquam erat volutpat. Nulla a ligula ac felis iaculis euismod efficitur eu velit. Aenean finibus quis eros sed ornare. Proin fringilla, velit eget viverra tempor, elit dui lobortis orci, eu hendrerit nunc augue a mauris. Phasellus placerat bibendum lectus non feugiat.",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      softWrap: false,
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed: () => { print("TODO: Assignment View Page") }, child: Text("View")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
