import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_prisma_mysql/src/generated/prisma/prisma_client.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _getUsers(context),
    HttpMethod.post => await _create(context),
    _ => _notFound(),
  };
}

Future<Response> _getUsers(RequestContext context) async {
  final prisma = context.read<PrismaClient>();
  final users = (await prisma.user.findMany()).toList();
  if (users.isEmpty) return _notFound();
  return Response.json(body: users);
}

Future<Response> _create(RequestContext context) async {
  final jsonBody = await context.request.json();
  final name = jsonBody['name'] as String?;
  final email = jsonBody['email'] as String;
  final prisma = context.read<PrismaClient>();
  final userCreated = await prisma.user.create(
    data: UserCreateInput(name: name, email: email),
  );
  return Response.json(
    statusCode: HttpStatus.created,
    body: userCreated,
  );
}

Response _notFound() {
  return Response.json(statusCode: 404);
}
