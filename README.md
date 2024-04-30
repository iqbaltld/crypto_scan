# Crypto Scan

This application is a small-scale Flutter project that displays a list of cryptocurrency pairs, allows users to search for specific coins, and mark them as favorites. It utilizes data from the Binance API to retrieve and display real-time price data and daily changes for each cryptocurrency.

## Features

- **List of Cryptocurrencies**: Shows the first 25 cryptocurrency pairs from the Binance API.
- **Search Functionality**: Allows users to search for specific cryptocurrency pairs.
- **Favorites**: Users can mark and view their favorite cryptocurrencies.
- **Real-Time Updates**: Displays real-time price data and daily changes using WebSocket.

## Technical Guidelines

- **API**: Cryptocurrency pairs are retrieved from the [Binance API](https://www.binance.com/fapi/v1/exchangeInfo). For more details, see the [Binance API Documentation](https://binance-docs.github.io/apidocs/futures/en/#exchange-information).
- **Real-Time Data**: Utilizes WebSocket market streams for real-time updates. More information can be found [here](https://binance-docs.github.io/apidocs/futures/en/#websocket-market-streams).

## Getting Started

### Prerequisites

Ensure you have Flutter installed on your development machine. The app is built using:

- Flutter 3.19.3
- Dart 3.3.1

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourgithub/flutter-crypto-trends.git
   ```
2. Navigate to the project directory:
   ```bash
   cd crypto_scan
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generating Code with Build Runner:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Run the App
4. After installation, run the app using the following command:
   ```bash
   flutter run
   ```

### Dependencies
- flutter_bloc: ^8.1.5
- http: ^1.2.1
- json_annotation: ^4.9.0
- fl_chart: ^0.67.0
- freezed_annotation: ^2.4.1
- web_socket_channel: ^2.4.5
- intl: ^0.19.0

### Dev Dependencies
- build_runner: ^2.4.9
- freezed: ^2.5.2
- json_serializable: ^6.8.0
