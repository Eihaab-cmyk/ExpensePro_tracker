import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/transactionDetails_screen.dart';
import 'package:flutter_app/data/model/add_date.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var history;
  // hive class to add transactions
  final box = Hive.box<Add_data>('data');
  // a list to store filtered transactions
  List<Add_data> filteredList = [];

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  // to show only the categories in the search bar
  void updatelist(String value) {
    // Clear the previous filtered list
    filteredList.clear();

    // Filter transactions based on the entered value
    for (int i = 0; i < box.length; i++) {
      Add_data transaction = box.getAt(i)!;
      if (transaction.name.toLowerCase().contains(value.toLowerCase())) {
        filteredList.add(transaction);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category wise search",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              style: TextStyle(color: Colors.grey[300]),
              onChanged: (value) {
                updatelist(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff4E4E61).withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "eg: food",
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.red,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount:
                    filteredList.length > 0 ? filteredList.length : box.length,
                itemBuilder: (context, index) {
                  if (box.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    history = filteredList.isNotEmpty
                        ? filteredList[index]
                        : box.getAt(index)!;
                    return getList(history, index);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getList(Add_data history, int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TransactionDetScreen(
                    name: history.name,
                    explain: history.explain,
                    amount: history.amount,
                    In: history.IN,
                    date: history.datetime.toString())));
          },
          child: Image.asset(
            'images/${history.name}.png',
            height: 40,
          ),
        ),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          color: Colors.grey[300],
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        history.datetime != null
            ? '${day[history.datetime.weekday - 1]} ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}'
            : 'Date not available',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
