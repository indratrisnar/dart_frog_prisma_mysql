import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_prisma_mysql/src/generated/prisma/prisma_client.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await _findById(context, id),
    HttpMethod.put => await _update(context, id),
    HttpMethod.delete => await _delete(context, id),
    _ => _notFound(),
  };
}

Future<Response> _findById(RequestContext context, String id) async {
  final prisma = context.read<PrismaClient>();
  try {
    final user = await prisma.user.findFirstOrThrow(
      where: UserWhereInput(
        id: IntFilter(equals: int.parse(id)),
      ),
    );
    return Response.json(body: user);
  } catch (e) {
    print(e);
    return _serverError();
  }
}

Future<Response> _update(RequestContext context, String id) async {
  final jsonBody = await context.request.json();
  final name = jsonBody['name'] as String?;
  final email = jsonBody['email'] as String;
  final prisma = context.read<PrismaClient>();
  final userUpdated = await prisma.user.update(
    data: UserUpdateInput(
      name: NullableStringFieldUpdateOperationsInput(set: name),
      email: StringFieldUpdateOperationsInput(set: email),
    ),
    where: UserWhereUniqueInput(id: int.parse(id)),
  );
  if (userUpdated == null) return _notFound();
  return Response.json(body: userUpdated);
}

Future<Response> _delete(RequestContext context, String id) async {
  final prisma = context.read<PrismaClient>();
  final userDeleted = await prisma.user.delete(
    where: UserWhereUniqueInput(id: int.parse(id)),
  );
  if (userDeleted == null) return _notFound();
  return Response.json(body: userDeleted);
}

Response _notFound() {
  return Response.json(statusCode: 404);
}

Response _serverError() {
  return Response.json(statusCode: HttpStatus.internalServerError);
}
