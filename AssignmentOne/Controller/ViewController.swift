//
//  ViewController.swift
//  AssignmentOne
//
//  Created by Mark Alford on 7/21/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - UIViews
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherResultText: UILabel!
    @IBOutlet weak var fahrenheitTemp: UILabel!
    @IBOutlet weak var celsiusTemp: UILabel!
    @IBOutlet weak var urlbutton: UIButton!
    
    
    //MARK: - Delegation and Button Setup
    var weatherManager = WeatherManager() //access to the networking file
    
    @IBAction func urlFetchButton(_ sender: UIButton) {
        
        //use the searchField.text to get the weather Method from networking file
        //if let is good for checking optionals
        if let city = searchInput.text { //THIS STARTS IT ALL IN THE WEATHER MANAGER
            weatherManager.fetchWeather(location: city)
        }
        
        print(fahrenheitTemp.text!)
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //disables button on launch
        urlbutton.isEnabled = false
        urlbutton.alpha = 0.1
        
        //setup all delegates: textfield and protocol
        searchInput.delegate = self
        weatherManager.delegate = self
    }
    
}


//MARK: - TextField Delegate
extension ViewController: UITextFieldDelegate {
    //ends the editing of the textfield, which performs same functionality of  func textFieldDidEndEditing
    
    //when enter button is pressed on keypad, execute code
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchInput.endEditing(true)
        print(searchInput.text!)
        return true
    }
    
    //if textfield has no input in it, when enter button is pressed, textfield will tell user to type first.
    //this blocks the 'no input to begin with' error when user doesnt even type anything in textfield.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchInput.text != ""{
            return true
        } else {
            searchInput.placeholder = "enter a city or zipcode"
            return false
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //textField code
        return true
    }
    
    
    //when the textfield stops editing officially, done by enter button on keypad
    func textFieldDidEndEditing(_ textField: UITextField) {
        urlbutton.isEnabled = true
        urlbutton.alpha = 1.0
    }
    
}

//MARK: - Thread for UI
extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.tempF)
        //1. Get valid string
        let string = "https:\(weather.image)"
        
        func getImage(from string: String) -> UIImage? {
            //2. Get valid URL
            guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
            }
            
            var image: UIImage? = nil
            do {
                //3. Get valid data
                let data = try Data(contentsOf: url, options: [])
                
                //4. Make image
                image = UIImage(data: data)
            }
            catch {
                print(error.localizedDescription)
            }
            
            return image
        }
        
        
       
        //Used to Change the UI with having to wait for the API call wait time
        DispatchQueue.main.async {
            if let image = getImage(from: string) {
                //5. Apply image
                self.weatherImage.image = image
            }
//            self.weatherImage.image = UIImage(named:"https:\(weather.image)")
            self.weatherResultText.text = weather.weatherResult
            self.celsiusTemp.text = String(weather.tempC)
            self.fahrenheitTemp.text = String(weather.tempF)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

