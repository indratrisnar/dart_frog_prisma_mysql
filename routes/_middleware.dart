import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_prisma_mysql/src/generated/prisma/prisma_client.dart';
import 'package:dotenv/dotenv.dart';

final env = DotEnv()..load();

final _prisma = PrismaClient(
  datasources: Datasources(
    db: env['DATABASE_URL'],
  ),
);

Handler middleware(Handler handler) {
  return handler
      .use(
        requestLogger(),
      )
      .use(
        provider<PrismaClient>((context) => _prisma),
      );
}
