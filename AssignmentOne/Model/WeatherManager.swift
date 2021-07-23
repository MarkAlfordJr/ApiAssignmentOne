//
//  WeatherManager.swift
//  AssignmentOne
//
//  Created by Mark Alford on 7/22/21.
//

import Foundation


//MARK: - Custom Delegate
//methods that will be used in ViewController
protocol WeatherManagerDelegate {
    //this is the func that ViewController will update its UI with
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

let constant = Constant()

struct WeatherManager {
    
    //MARK: - Url Setup
    
  
    //for security reasons, please provide own api key
    let apiKey = constant.privateApiKey
    let apiUrl = "http://api.weatherapi.com/v1/current.json?key="
    
    //ACTIVATES the api through user entering location
    func fetchWeather (location userInput: String) {
        let urlString = "\(apiUrl)\(apiKey)&q=\(userInput)"
        //perform request using the city name
        performRequest(with: urlString)
    }
    
    
    //MARK: - Delegate Key Activation
    //delegate for ViewController to use
    var delegate: WeatherManagerDelegate?
    
    
    
    //MARK: - API Networking Functionality
    //setup Networking Function
    func performRequest (with urlString: String) {
        //1 create url
        if let url = URL(string: urlString) {
            //2 create the urlSession
            let session = URLSession(configuration: .default)
            //3 give the urlSession a task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in //trailing closure
                //if there is an error in getting back the data, print the error
                if error != nil{
                    //RUN THIS WHEN DELEGATE IS FINALLY CREATED
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                //if the data from the webserver is good, print and store data
                if let safeData = data {
                    //RUN YOUR JSON PARSING FUNCTION WHEN ITS STRUCT IS SETUP
                    //5 refer to the parsing function
                    if let weather = self.parseJSON(safeData){
                        //only use this to access the Model/Logic file's vars and func
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4 perform the task
            task.resume()
        }
    }
    
    //MARK: - JSON Parsing
    func parseJSON (_ weatherData: Data) -> WeatherModel? {
        //1 access the Json decoding class
        let decoder = JSONDecoder()
        //2 setup parse with do and catch
        do {
            //3 this gets access to WeatherData file, where we PARSE and intialize ALL properties.
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let parsedTempF = decodedData.current.temp_f
            let parsedTempC = decodedData.current.temp_c
            let parsedWeatherText = decodedData.current.condition.text
            let parsedImage = decodedData.current.condition.icon
            
            let weatherLogic = WeatherModel(tempF: parsedTempF, tempC: parsedTempC, weatherResult: parsedWeatherText, image: parsedImage)
            
            //testing out data
            print(decodedData.current.condition.text)
            print(decodedData.current.temp_f)
            print(decodedData.current.temp_c)
            
            return weatherLogic
            
            
        }  catch{
            print(error)
            return nil
        }
        
    }
    
    
}

