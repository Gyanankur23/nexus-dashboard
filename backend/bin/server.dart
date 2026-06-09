import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors/shelf_cors.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// Mock Data
Map<String, dynamic> mockUsers = {
  'users': [
    {'id': 1, 'name': 'Admin User', 'email': 'admin@nexus.com', 'role': 'admin', 'avatar': '👨‍💼', 'status': 'active', 'joined': '2024-01-15'},
    {'id': 2, 'name': 'John Developer', 'email': 'john@nexus.com', 'role': 'developer', 'avatar': '👨‍💻', 'status': 'active', 'joined': '2024-02-20'},
    {'id': 3, 'name': 'Sarah Designer', 'email': 'sarah@nexus.com', 'role': 'designer', 'avatar': '👩‍🎨', 'status': 'active', 'joined': '2024-03-10'},
    {'id': 4, 'name': 'Mike Manager', 'email': 'mike@nexus.com', 'role': 'manager', 'avatar': '👨‍💼', 'status': 'inactive', 'joined': '2024-01-05'},
  ]
};

Map<String, dynamic> mockProjects = {
  'projects': [
    {'id': 1, 'name': 'Website Redesign', 'status': 'in-progress', 'progress': 65, 'team': [1, 2, 3], 'deadline': '2024-07-15', 'priority': 'high'},
    {'id': 2, 'name': 'Mobile App Development', 'status': 'in-progress', 'progress': 40, 'team': [2, 3], 'deadline': '2024-08-20', 'priority': 'high'},
    {'id': 3, 'name': 'API Integration', 'status': 'completed', 'progress': 100, 'team': [2], 'deadline': '2024-05-30', 'priority': 'medium'},
    {'id': 4, 'name': 'Database Migration', 'status': 'pending', 'progress': 0, 'team': [2, 4], 'deadline': '2024-09-01', 'priority': 'low'},
  ]
};

Map<String, dynamic> mockTasks = {
  'tasks': [
    {'id': 1, 'projectId': 1, 'title': 'Design homepage mockup', 'status': 'done', 'assignee': 3, 'priority': 'high'},
    {'id': 2, 'projectId': 1, 'title': 'Implement responsive layout', 'status': 'in-progress', 'assignee': 2, 'priority': 'high'},
    {'id': 3, 'projectId': 1, 'title': 'Add animations', 'status': 'todo', 'assignee': 3, 'priority': 'medium'},
    {'id': 4, 'projectId': 2, 'title': 'Setup React Native', 'status': 'done', 'assignee': 2, 'priority': 'high'},
    {'id': 5, 'projectId': 2, 'title': 'Build login screen', 'status': 'in-progress', 'assignee': 2, 'priority': 'high'},
    {'id': 6, 'projectId': 2, 'title': 'Integrate API', 'status': 'todo', 'assignee': 2, 'priority': 'medium'},
  ]
};

Map<String, dynamic> mockStats = {
  'totalUsers': 4,
  'activeUsers': 3,
  'totalProjects': 4,
  'completedProjects': 1,
  'totalTasks': 6,
  'completedTasks': 2,
  'productivity': 78,
};

String _hashPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}

String _generateToken(Map<String, dynamic> user) {
  final jwt = JWT({
    'id': user['id'],
    'email': user['email'],
    'role': user['role'],
  });
  return jwt.sign(SecretKey('nexus-secret-key-2024'));
}

bool _verifyToken(String token) {
  try {
    JWT.verify(token, SecretKey('nexus-secret-key-2024'));
    return true;
  } catch (e) {
    return false;
  }
}

// Routes
Handler _createRouter() {
  final app = Router();

  // Health check
  app.get('/', (Request request) {
    return Response.ok(jsonEncode({'status': 'healthy', 'service': 'Nexus Dashboard API'}), headers: {'Content-Type': 'application/json'});
  });

  // Auth endpoints
  app.post('/auth/login', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    
    // Simple mock authentication
    if (data['email'] == 'admin@nexus.com' && data['password'] == 'admin123') {
      final token = _generateToken({'id': 1, 'email': 'admin@nexus.com', 'role': 'admin'});
      return Response.ok(jsonEncode({
        'success': true,
        'token': token,
        'user': {'id': 1, 'name': 'Admin User', 'email': 'admin@nexus.com', 'role': 'admin', 'avatar': '👨‍💼'}
      }), headers: {'Content-Type': 'application/json'});
    }
    
    return Response(401, body: jsonEncode({'success': false, 'message': 'Invalid credentials'}), headers: {'Content-Type': 'application/json'});
  });

  // Users endpoints
  app.get('/users', (Request request) {
    return Response.ok(jsonEncode(mockUsers), headers: {'Content-Type': 'application/json'});
  });

  app.get('/users/<id>', (Request request, String id) {
    final user = mockUsers['users'].firstWhere((u) => u['id'].toString() == id, orElse: () => null);
    if (user == null) {
      return Response(404, body: jsonEncode({'message': 'User not found'}), headers: {'Content-Type': 'application/json'});
    }
    return Response.ok(jsonEncode(user), headers: {'Content-Type': 'application/json'});
  });

  // Projects endpoints
  app.get('/projects', (Request request) {
    return Response.ok(jsonEncode(mockProjects), headers: {'Content-Type': 'application/json'});
  });

  app.get('/projects/<id>', (Request request, String id) {
    final project = mockProjects['projects'].firstWhere((p) => p['id'].toString() == id, orElse: () => null);
    if (project == null) {
      return Response(404, body: jsonEncode({'message': 'Project not found'}), headers: {'Content-Type': 'application/json'});
    }
    return Response.ok(jsonEncode(project), headers: {'Content-Type': 'application/json'});
  });

  // Tasks endpoints
  app.get('/tasks', (Request request) {
    return Response.ok(jsonEncode(mockTasks), headers: {'Content-Type': 'application/json'});
  });

  app.get('/tasks/project/<projectId>', (Request request, String projectId) {
    final tasks = mockTasks['tasks'].where((t) => t['projectId'].toString() == projectId).toList();
    return Response.ok(jsonEncode({'tasks': tasks}), headers: {'Content-Type': 'application/json'});
  });

  // Stats endpoint
  app.get('/stats', (Request request) {
    return Response.ok(jsonEncode(mockStats), headers: {'Content-Type': 'application/json'});
  });

  // Dashboard data endpoint
  app.get('/dashboard', (Request request) {
    return Response.ok(jsonEncode({
      'stats': mockStats,
      'recentProjects': mockProjects['projects'].take(3).toList(),
      'recentTasks': mockTasks['tasks'].take(5).toList(),
      'users': mockUsers['users'],
    }), headers: {'Content-Type': 'application/json'});
  });

  final handler = Cascade()
      .add(createMiddleware(
        requestHandler: (request) {
          if (request.url.path == '/' || request.url.path.startsWith('/auth')) {
            return null;
          }
          final authHeader = request.headers['Authorization'];
          if (authHeader == null || !authHeader.startsWith('Bearer ')) {
            return Response(401, body: jsonEncode({'message': 'Unauthorized'}), headers: {'Content-Type': 'application/json'});
          }
          final token = authHeader.substring(7);
          if (!_verifyToken(token)) {
            return Response(401, body: jsonEncode({'message': 'Invalid token'}), headers: {'Content-Type': 'application/json'});
          }
          return null;
        },
      ))
      .add(app);

  return handler;
}

void main() async {
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(_createRouter());

  final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('Nexus Dashboard API running on http://${server.address.host}:${server.port}');
}

Middleware corsHeaders() {
  return createMiddleware(
    responseHandler: (Response response) {
      return response.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        ...response.headers,
      });
    },
  );
}
