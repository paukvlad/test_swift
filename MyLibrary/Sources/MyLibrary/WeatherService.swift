import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
    func getTemperatureMin() async throws -> Int
    func getTemperatureMax() async throws -> Int
//    func getLongitude() async throws -> Double
//    func getLattitude() async throws -> Double
}

enum BaseUrl : String {
    case realServer = "https://api.openweathermap.org"
    case mockServer = "http://localhost:3000"
}

let city = "corvallis"

class WeatherServiceImpl: WeatherService {
    
    let url = "\(BaseUrl.realServer.rawValue)/data/2.5/weather?q=\(city)&units=imperia&appid=9ff3f9fc842d2eede2111794714c1adf"
    
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))
                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    func getTemperatureMin() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature_min = weather.main.temp_min
                    let temperatureMinAsInteger = Int(temperature_min)
                    continuation.resume(with: .success(temperatureMinAsInteger))
                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func getTemperatureMax() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature_max = weather.main.temp_max
                    let temperatureMaxAsInteger = Int(temperature_max)
                    continuation.resume(with: .success(temperatureMaxAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
//    func getLongitude() async throws -> Double {
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
//                switch response.result {
//                case let .success(weather):
//                    let longitude = weather.coord.lon
//                    let longitudeIsDouble = Double(longitude)
//                    continuation.resume(with: .success(longitudeIsDouble))
//
//                case let .failure(error):
//                    continuation.resume(with: .failure(error))
//                }
//            }
//        }
//    }
//
//    func getLattitude() async throws -> Double {
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
//                switch response.result {
//                case let .success(weather):
//                    let lattitude = weather.coord.lat
//                    let lattitudeIsDouble = Double(lattitude)
//                    continuation.resume(with: .success(lattitudeIsDouble))
//
//                case let .failure(error):
//                    continuation.resume(with: .failure(error))
//                }
//            }
//        }
//    }
}

struct Weather: Decodable {
    let main: Main
    let coord: Coord
    
    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    struct Coord: Decodable {
        let lat: Double
        let lon: Double
    }
}
