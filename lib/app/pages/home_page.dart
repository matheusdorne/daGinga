import 'package:daginga_server_status/app/data/repositories/services_repositories.dart';
import 'package:daginga_server_status/app/pages/store/service_store.dart';
import 'package:flutter/material.dart';
import '../data/http/http_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ServicesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('daGinga Server Status')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: Icons.dashboard_rounded,
            label: 'Dashboard',
            selectedColor: Colors.blue,
          ),
          NavigationDestination(
            icon: Icons.miscellaneous_services,
            label: 'Services',
            selectedColor: Colors.blue,
          ),
          NavigationDestination(
            icon: Icons.account_circle_rounded,
            label: 'Profile',
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Dashboard Screen',
        style: TextStyle(fontSize: 24),

      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final ServiceStore store = ServiceStore(
      repository: ServicesRepositoryImpl(
        client: HttpClientImpl(),
      ),
    );
    store.getServices();
    return  Center(
      child: AnimatedBuilder(animation: Listenable.merge([
        store.isLoading,
        store.error,
        store.state,
      ]),
      builder: (context, _) {
        if (store.isLoading.value) {
          return const CircularProgressIndicator();
        }

        if (store.error.value.isNotEmpty) {
          return Text(store.error.value!);
        }

        return ListView.builder(
          itemCount: store.state.value.length,
          itemBuilder: (context, index) {
            final service = store.state.value[index];
            return ListTile(
              title: Text(service.name),
              subtitle: Text(service.description),
            );
          },
        );
      }


    ));}
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class NavigationDestination {
  final IconData icon;
  final String label;
  final Color selectedColor;

  NavigationDestination({
    required this.icon,
    required this.label,
    required this.selectedColor,
  });
}

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;

  const NavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: Icon(destination.icon),
          label: destination.label,
          activeIcon: Icon(
            destination.icon,
            color: destination.selectedColor,
          ),
        );
      }).toList(),
    );
  }
}
