# dart_frog_prisma_mysql

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

# Channel Tutor

[Flutter Delux](https://www.youtube.com/channel/UC0d_xINEvCtlDCpWfBpnYpA)

[This Tutorial](https://youtu.be/oT4BMmsullI)

# Prisma Setup CLI

https://prisma.pub/

- Install prisma  
  `npm install prisma`

- Init prisma setup  
  `npx prisma init --generator-provider="dart run orm"`

- Generate prisma  
  `npx prisma generate`

- If prisma not generate, create model inside prisma schema, add dependency for build:  
  dependencies: `json_annotation: ^4.8.1`, `build_runner: ^2.4.8`,  
  dev_dependencies: `json_serializable: ^6.7.1`  
  execute command to generate file: `dart run build_runner build`

- migrate database and table  
  `npx prisma db push`
