import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../component/colo_extension.dart';
import '../fierstore/saveGoalAndProgress.dart';
import '../provider/kickCounterProvider.dart';
import '../vision_detector_views/object_detector_view.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _goalController = TextEditingController();
  int _selectedIndex = 0;
  int? _goal;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final doc = await userDoc.collection('goals').doc(today).get();

      if (doc.exists) {
        setState(() {
          _goal = doc.data()!['goal'];
          _progress = doc.data()!['progress'] ?? 0;
        });
      }
    } catch (e) {
      print('Error loading goal: $e');
    }
  }

  Future<void> _saveGoal(int goal, int progress) async {
    print("Called saveGoal");
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      print("Userid: " + user.uid);

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // 사용자의 목표와 진행상황을 Firestore에 저장
      await userDoc.collection('goals').doc(today).set({
        'goal': goal,
        'progress': progress,
      });

      setState(() {
        _goal = goal;
      });

      print("Today's goal saved: $_goal");
    } catch (error) {
      print("Error saving goal: $error");
    }
  }

  void signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('Sign out successful');
      Provider.of<KickCounterProvider>(context, listen: false).reset();
      Navigator.pushNamedAndRemoveUntil(
          context, '/auth', (route) => false); //로그인 페이지로 이동 후 스택 초기화
    } catch (e) {
      print('Sign out failed: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kickCounterProvider = Provider.of<KickCounterProvider>(context);
    print("count: ${kickCounterProvider.count}");

    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("PAMAS"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  if (_goal == null)
                    Column(
                      children: [
                        Text(
                          'How many kicks would you like to train today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextField(
                            controller: _goalController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter your goal',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            int goal = int.tryParse(_goalController.text) ?? 0;
                            kickCounterProvider.setGoal(goal);
                            _saveGoal(kickCounterProvider.goal,
                                kickCounterProvider.count);
                            setState(() {});
                          },
                          child: Text('Save Goal'),
                        ),
                      ],
                    ),
                  if (_goal != null) // Goal이 있을 때만 ExpansionTile 표시
                    Column(
                      children: [
                        Text(
                          "Today's Goal",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${kickCounterProvider.count} / ${kickCounterProvider.goal}', // KickCounterProvider의 count 사용
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 70,
                  ),
                  if (_goal != null) // Goal이 있을 때만 ExpansionTile 표시
                    ExpansionTile(
                      title: const Text('Vision for Pass'),
                      children: [
                        CustomCard('Object Detection', ObjectDetectorView()),
                        CustomCard('Pose Detection', PoseDetectorView()),
                      ],
                    ),
                  if (_goal != null)
                    SizedBox(
                      height: 200,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: TColor.primaryColor1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'PAssing MASter',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('On Boarding'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pushNamed(context, '/onboarding');
              },
            ),
            ListTile(
              title: const Text('My page'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}
