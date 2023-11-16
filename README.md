# nasa-immersive-otd
NASA Immersive of the Day - A showcase project all developed by myself

# Build instruction
Create a api-key.json file with your key as the template in the root folder:
`{
    "API_KEY": "...your-key..."
}
` 

# Motivation
I am developing this project to expose my developer skills and evaluate my submission on a code challenge interview process. Although the scope was defined in the code challenge requirements, I will be looking forward to expanding and building it in such a way that any other developer could contribute like on a team-scale project, so could be there some boilerplate. I would like also to update myself on the nearest design patterns and practices for the Flutter stack while I'm adding new features.

# Development strategy
- Code from the core to the border - 1. Services, 2. Domain, 3. Data, 4. Presenter.
- Use the clean architecture approach. [link](https://github.com/Flutterando/Clean-Dart)
- Unit test each layer as it is finished.
- The navigation and injection dependency will use Modular. [link](https://pub.dev/packages/flutter_modular)
- REST communication services will use Dio and the local storage will use SharedPreferences.
- No code generation will be used at all.

# External resources
- NASA endpoint - https://api.nasa.gov/planetary/apod
- User device storage - powered by SharedPreferences

# Composition - Services
- Api service
- Local Storage service

# Composition - Domain
- Immersive entity
- Custom exceptions

# Composition - Data
- Immersive dto
- Immersive datasource
- Immersive repository

# Composition - Presenter
- Timeline screen bloc
- Timeline screen widgets
- Detail screen widgets