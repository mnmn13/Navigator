# Navigator

Navigator is an iOS application that allows users to track their routes during the day or a specific period of time. It provides functionality for route tracking, city search, and cloud storage with user authentication.

## Features

- Route Tracking: Users can start and stop route monitoring, which sends the current location every 100 meters and saves the route data.
- City Search: Users can enter a city name and the app will display the route between the current location and the specified city.
- User Authentication: The app utilizes authentication to securely store and retrieve route data in the cloud.
- Table View: The app includes a table view to display the timestamp and coordinates of each recorded point on the route.
- MVVM-C Architecture: The app follows the Model-View-ViewModel with Coordinator architectural pattern for a structured and scalable codebase.

## Functionality

1. Start Monitoring: Users can start route monitoring by tapping the "Start Monitoring" button. The app will send the current location every 100 meters and save the route data.
2. Stop Monitoring: Tapping the "Stop Monitoring" button will stop the route monitoring and data collection.
3. City Route: Users can enter a city name in the search bar and the app will display the route between the current location and the specified city.
4. Clear Route: The "Clear Route" button allows users to delete the saved route data and start fresh.
5. Route History: The table view presents a list of recorded points on the route, including the timestamp and coordinates.

## Installation

To run Navigator locally, follow these steps:

1. Clone the repository: `git clone https://github.com/mnmn13/navigator.git`
2. Open the project in Xcode.
3. Build and run the app on the desired simulator or device.

## Requirements

- iOS 13.0+
- Xcode 12.0+

## License

This project is licensed under the [MIT License](LICENSE).
