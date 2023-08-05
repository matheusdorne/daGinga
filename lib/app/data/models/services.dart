
class Service {
  final String name;
  final String description;
  final ServiceType type;
  final ServiceStatus status;
  final DateTime lastUpdate;

  Service({
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.lastUpdate,
  });

   factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'],
      description: map['description'],
      type: map['type'],
      status: map['status'],
      lastUpdate: map['lastUpdate'],
    );
  }

}

enum ServiceType { APPLICATION, SERVICE, SERVER }

enum ServiceStatus { GREEN, YELLOW, RED }


