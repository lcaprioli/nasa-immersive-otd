# nasa-immersive-otd
NASA Immersive of the Day - A showcase project all developed by myself

# Motivation
I am developing this project to expose my developer skills and evaluate my submission on a code challenge interview process. Although the scope was defined in the code challenge requirements, I will be looking forward to expanding and building it in such a way that any other developer could contribute like on a team-scale project, so could be there some boilerplate. I would like also to update myself on the nearest design patterns and practices for the Flutter stack while I'm adding new features.

# Development strategy
- Code from the core to the border - 1. Services, 2. Domain, 3. Infra, 4. Presenter.
- Use the clean architecture approach. [link](https://github.com/Flutterando/Clean-Dart)
- Unit test each layer as it is finished.
- The navigation and injection dependency will use Modular. [link](https://pub.dev/packages/flutter_modular)
- REST communication services will use Dio and the local storage will use Hive.
- No code generation will be used at all.

# External resources
- NASA endpoint - https://api.nasa.gov/planetary/apod
- User device storage - powered by Hive

# Composition - Services
- Api service
- Hive service

# Composition - Domain
- Timeline dto
- Detail dto
- Timeline entity
- Detail entity
- Get timeline usecase
- Get detail usecase

# Composition - Infra
- Apod driver
- Apod repository

# Composition - Presenter
- Timeline screen bloc
- Detail screen cubit
- Presenter widgets

# Composition - Utils
- Text consts
- Material theme
