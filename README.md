# TrackRoute

## Installation

Xcode config is based on Xcodegen. In order to configure your local environment you're going to need to execute:

```bash
./prepare_environment.sh
```

## About the code

The code is structured following CLEAN principles. It is splitted into the following layers:
* **Domain**: Business logic and core logic of the app
* **Data**: Layer that handles the origin of the data the app presents
* **Networking**: Abstraction of the networking layer
* **Presentation**: Layer in charge of presenting the information to the user
* **Components**: Provides the DSL for the application
* **App**: Represents the final binary which is going to be delivered to the user

## Dependencies

Dependencies are intended to be delivered as precompiled frameworks. `Polyline` and `OHHTTPStubs`don't provide a precompiled xcframework so we're going to use them in the source code.

* **DependencyInjection**: Is located in frameworks (usually I'll distribute it through SPM instead of adding it on the repo). If you want to check the code it's located [here](https://github.com/AlbGarciam/DependencyInjection). Allows dependency inversion in a simple manner.
* **OHHTTPStubs**: Makes network testing easier.
* **Polyline**: Requested by the project
