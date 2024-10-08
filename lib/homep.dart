import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homep extends StatefulWidget {
  const Homep({super.key});

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  Color mainc = Colors.red; 
  Color mc = Colors.red;
  int _count = 0;
  int time = 0;
  int goal = 0;
  int sc = 0;

  @override
  void initState() {
    super.initState();
    getCount(); // Make sure this is called after super.initState()
  }

  Future<void> setCount(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('count', value); // Ensure you're awaiting it
    print("Count set to: $value");
  }

  Future<void> getCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('count') ?? 0; // Default to 0 if null
    });
    print("Count retrieved: $_count");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add any action you want on button press
        },
        backgroundColor: mc,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: mc,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.color_lens, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(color: mc),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("الهدف", style: TextStyle(color: Colors.white, fontSize: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          goal--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle, color: Colors.white),
                    ),
                    Text("$goal", style: const TextStyle(color: Colors.white, fontSize: 30)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          goal++;
                        });
                      },
                      icon: const Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGoalButton(0),
                    const SizedBox(width: 9),
                    _buildGoalButton(33),
                    const SizedBox(width: 9),
                    _buildGoalButton(100),
                    const SizedBox(width: 9),
                    _buildGoalButton(1000),
                    const SizedBox(width: 9),
                    _buildGoalButton(10000),
                    const SizedBox(width: 9),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Text("الاسِتغفار", style: TextStyle(fontSize: 40, color: mc)),
              const SizedBox(height: 10),
              Text("$_count", style: TextStyle(fontSize: 30, color: mc)),
              const SizedBox(height: 20),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: goal == 0 ? 0 : _count / goal,
                center: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_count == goal) {
                        _count = 0;
                        time++;
                      }
                      setCount(_count++); // Update count after increment
                    });
                  },
                  icon: Icon(Icons.touch_app, size: 50.0, color: mc),
                ),
                backgroundColor: mc.withOpacity(0.2),
                progressColor: mc,
              ),
              const SizedBox(height: 20),
              Text("مرّات التكرار : $time", style: TextStyle(fontSize: 20, color: mc)),
              const SizedBox(height: 10),
              Text("المجمُوع : $sc", style: TextStyle(fontSize: 20, color: mc)),
              const SizedBox(height: 10),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColorRadio(Colors.red),
              _buildColorRadio(Colors.blue),
              _buildColorRadio(const Color.fromARGB(255, 239, 196, 67)),
              _buildColorRadio(const Color.fromARGB(255, 70, 68, 68)),
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildGoalButton(int goalValue) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _count = 0;
            goal = goalValue;
          });
        },
        child: Text("$goalValue", style: TextStyle(color: mc)),
      ),
    );
  }

  Widget _buildColorRadio(Color color) {
    return Row(
      children: [
        Radio<Color>(
          activeColor: color,
          value: color,
          groupValue: mc,
          onChanged: (val) {
            setState(() {
              mc = val!;
              mainc = val;
            });
          },
        ),
      ],
    );
  }
}