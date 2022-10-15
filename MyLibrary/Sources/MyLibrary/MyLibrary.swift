public class MyLibrary {
    private let weatherService: WeatherService

    /// The class's initializer.
    ///
    /// Whenever we call the `MyLibrary()` constructor to instantiate a `MyLibrary` instance,
    /// the runtime then calls this initializer.  The constructor returns after the initializer returns.
    public init(weatherService: WeatherService? = nil) {
        self.weatherService = weatherService ?? WeatherServiceImpl()
    }

//    public func isCorvallis(_ city: String) async -> Bool? {
//        // Check the simple case first: "corvallis" is automatically lucky.
//        if city == "corvallis" {
//            return true
//        }
//
//        // Fetch the coordinates from the backend.
//        // If the coordinates match the coordinates of Corvallis then it's true
//        do {
//            let longitude = try await weatherService.getLongitude()
//            let lattitude = try await weatherService.getLattitude()
//            return longitude.isEqual(to: 123.262) && lattitude.isEqual(to: 44.5646)
//        } catch {
//            return nil
//        }
//    }
    
    public func isTemperatureCorrect(_ number: Double) async -> Bool? {
        // Check the simple case first: temperature 250 is automatically correct.
        if number == 250 {
            return true
        }

        // Fetch the current weather from the backend.
        // If the current temperature, in Farenheit, contains an 8, then that's lucky.
        do {
            let temperature = try await weatherService.getTemperature()
            let temperatureMin = try await weatherService.getTemperatureMin()
            let temperatureMax = try await weatherService.getTemperatureMax()
            return temperature <= temperatureMax && temperature >= temperatureMin
        } catch {
            return nil
        }
    }
    
    public func isLucky(_ number: Int) async -> Bool? {
        // Check the simple case first: 3, 5 and 8 are automatically lucky.
        if number == 3 || number == 5 || number == 8 {
            return true
        }

        // Fetch the current weather from the backend.
        // If the current temperature, in Farenheit, contains an 8, then that's lucky.
        do {
            let temperature = try await weatherService.getTemperature()
            return temperature.contains("8")
        } catch {
            return nil
        }
    }
}

private extension Int {
    /// Sample usage:
    ///   `558.contains(558, "8")` would return `true` because 588 contains 8.
    ///   `557.contains(557, "8")` would return `false` because 577 does not contain 8.
    func contains(_ character: Character) -> Bool {
        return String(self).contains(character)
    }
}
