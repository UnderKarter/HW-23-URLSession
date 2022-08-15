import UIKit

let configureSession = URLSessionConfiguration.default
configureSession.allowsCellularAccess = true
configureSession.waitsForConnectivity = true
let session = URLSession(configuration: configureSession)

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    
    session.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("Error is: \(error?.localizedDescription ?? "")")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Server responce is: \(response.statusCode)")
            
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print("Our data is: \(dataAsString ?? "Nothing")")
            
        } else if let response = response as? HTTPURLResponse {
            print("Server responce is: \(response.statusCode)")
            return
        }
        
    }.resume()
}

let baseWeatherUrl = "https://data.weather.gov.hk/weatherAPI/opendata/weather.php?"
let nineDayEngWeather = baseWeatherUrl + "dataType=fnd&lang=eng"
let nineDayChWeather = baseWeatherUrl + "dataType=fnd&lang=tc"

getData(urlRequest: nineDayEngWeather)
getData(urlRequest: nineDayChWeather)
