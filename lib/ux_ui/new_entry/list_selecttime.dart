import 'package:flutter/material.dart';

class ListSelectTime extends StatefulWidget {
  @override
  ListSelectTimeState createState() {
    return new ListSelectTimeState();
  }
}

class ListSelectTimeState extends State<ListSelectTime> {
  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listKey2 = GlobalKey();

  // backing data
  List<String> _data = [];
  List<String> _interval = [];
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            SizedBox(
              height: 300,
              width: 100,
              child: AnimatedList(
                // Give the Animated list the global key
                key: _listKey,
                initialItemCount: _data.length,
                // Similar to ListView itemBuilder, but AnimatedList has
                // an additional animation parameter.
                itemBuilder: (context, index, animation) {
                  // Breaking the row widget out as a method so that we can
                  // share it with the _removeSingleItem() method.
                  return _buildItem(_data[index], animation);
                },
              ),
            ),
          ],
        ),
        DropdownButton<int>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              dropdownValue = newValue;
              int interval = 0;
              print("dropdownValue :$dropdownValue");
              if (_interval.length != 0) {
                for (int i = _interval.length; i > 0; i--) {
                  _removeSingleItemInterval();
                  dropdownValue = newValue;
                }
                for (int i = dropdownValue; i > 0; i--) {
                  interval++;
                  _insertSingleItemInterval(interval);
                }
              } else {
                for (int i = dropdownValue; i > 0; i--) {
                  interval++;
                  _insertSingleItemInterval(interval);
                }
              }
              // for (int i = dropdownValue; i > 0; i--) {
              //   _insertSingleItemInterval();
              // }
            });
          },
          items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        RaisedButton(
          child: Text('Insert item', style: TextStyle(fontSize: 20)),
          onPressed: () {
            _insertSingleItem();
          },
        ),
        RaisedButton(
          child: Text('Remove item', style: TextStyle(fontSize: 20)),
          onPressed: () {
            for (int i = _data.length; i >= 0; i--) {
              _removeSingleItem();
            }
          },
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: AnimatedList(
            // Give the Animated list the global key
            key: _listKey2,
            initialItemCount: _interval.length,
            // Similar to ListView itemBuilder, but AnimatedList has
            // an additional animation parameter.
            itemBuilder: (context, index, animation) {
              // Breaking the row widget out as a method so that we can
              // share it with the _removeSingleItem() method.
              return _buildItem2(_interval[index], animation);
            },
          ),
        ),
      ],
    );
  }

  // This is the animated row with the Card.
  Widget _buildItem(String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: RaisedButton(
          child: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildItem2(String item2, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: RaisedButton(
          child: Text(
            item2,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _insertSingleItem() {
    String newItem = "Planet";

    // Arbitrary location for demonstration purposes
    int insertIndex = 0;
    // Add the item to the data list.
    _data.insert(insertIndex, newItem);
    // Add the item visually to the AnimatedList.
    _listKey.currentState.insertItem(insertIndex);
    print("add : $_data");
  }

  void _removeSingleItem() {
    int removeIndex = 0;

    // Remove item from data list but keep copy to give to the animation.
    String removedItem = _data.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation);
    };
    // Remove the item visually from the AnimatedList.
    _listKey.currentState.removeItem(removeIndex, builder);
    print("deledt : $_data");
  }

  void _removeSingleItemInterval() {
    int removeIndex = 0;

    // Remove item from data list but keep copy to give to the animation.
    String removedItem = _interval.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem2(removedItem, animation);
    };
    // Remove the item visually from the AnimatedList.
    _listKey2.currentState.removeItem(removeIndex, builder);
    print("deledtinter : $_interval");
  }

  void _insertSingleItemInterval(interval) {
    String newItem = "$interval";

    // Arbitrary location for demonstration purposes
    int insertIndex = 0;
    // Add the item to the data list.
    // _interval.insert(insertIndex, newItem);
    _interval.add(newItem);
    // Add the item visually to the AnimatedList.
    _listKey2.currentState.insertItem(insertIndex);
    print("add : $_interval");
  }
}
