import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  AddTodo({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7F0900),

      // app bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF7F0900),
        title: Text(
          "Add a task",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[300],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                // logo for add
                Image.asset(
                  'images/todoGIF.gif',
                  height: 50,
                ),

                const SizedBox(height: 25),

                // taskname
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: controller,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      hintText: 'Task name',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Save button
                GestureDetector(
                  onTap: () {
                    onSave();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.deepOrange[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.timelapse,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Text(
                            "Tip:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Utilizing the to-do feature in your expense tracking journey is a strategic move. Consider documenting short-term financial goals or upcoming bills to enhance your financial planning. This functionality acts as a structured roadmap for managing your expenses efficiently. Stay organized with your to-dos, and witness a seamless alignment of your financial objectives.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
