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
// MARK: - Basic task
let baseWeatherUrl = "https://data.weather.gov.hk/weatherAPI/opendata/weather.php?"
let nineDayEngWeather = baseWeatherUrl + "dataType=fnd&lang=eng"
let nineDayChWeather = baseWeatherUrl + "dataType=fnd&lang=tc"

getData(urlRequest: nineDayEngWeather)
getData(urlRequest: nineDayChWeather)

// MARK: - Extra task
let baseMarvelUrl = "http://gateway.marvel.com/v1/public/comics/20/characters?ts=1&apikey="
let publicKey = "d65777e97313d67a6e9b67aedd1082f6"
let privateKey = "c125b0157f48a2082a05783f47afb736e3cfffc8"
let ts = "1"

func md5Hash(_ source: String) -> String {
    return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
}

let hash = md5Hash(ts + privateKey + publicKey)
let endpointUrl = baseMarvelUrl + publicKey + "&hash=" + hash

getData(urlRequest: endpointUrl)
