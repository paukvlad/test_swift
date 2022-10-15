import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    
    func testFilepath() throws {
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        
        XCTAssertNotNil(filePath)
    }
    
    func testTemperature() throws {
        // Given
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        
        // When
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
        let temp = weather.main.temp
        let temp_min = weather.main.temp_min
        let temp_max = weather.main.temp_max
        
        // Then
        XCTAssertTrue(temp <= temp_max && temp >= temp_min, "Current temperature is out of min/max range!")
    }
    
    func testTemperatureService() async throws {
        let WeatherService = WeatherServiceImpl()

        let myLibrary = MyLibrary(weatherService: WeatherService)

        // When
        let temperature = await myLibrary.isTemperatureCorrect(1)

        // Then
        XCTAssertNotNil(temperature)
        XCTAssert(temperature == true)
    }
    
    func testLocationJSON() throws {
        // Given
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        
        // When
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
        let lon = weather.coord.lon
        let lat = weather.coord.lat
        
        // Then
        if (city == "corvallis") {
            XCTAssertTrue(lon == 123.262 && lat == 44.5646)
        }
    }
    
//    func testLocationMock() throws {
//        // Given
//        let mockWeatherService = MockWeatherService(
//            shouldSucceed: true,
//            shouldReturnTemperatureWithAnEight: false
//        )
//
//        let myLibrary = MyLibrary(weatherService: mockWeatherService)
//
//        // When
//        let isLuckyNumber = await myLibrary.isLucky(8)
//        
//        let jsonData = Data(jsonString.utf8)
//        let jsonDecoder = JSONDecoder()
//        
//        
//        
//        // When
//        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
//        let lon = weather.coord.lon
//        let lat = weather.coord.lat
//        
//        // Then
//        if (city == "corvallis") {
//            XCTAssertTrue(lon == 123.262 && lat == 44.5646)
//        }
//    }
    
//    func testIsCorvallis() async {
//        // Given
//        let mockWeatherService = MockWeatherService(
//            shouldSucceed: true,
//            shouldReturnTemperatureWithAnEight: false
//        )
//
//        let myLibrary = MyLibrary(weatherService: mockWeatherService)
//
//        // When
//        let isCityCorvallis = await myLibrary.isCorvallis("corvallis")
//
//        // Then
//        XCTAssertNotNil(isCityCorvallis)
//        XCTAssert(isCityCorvallis == true)
//    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }

}
