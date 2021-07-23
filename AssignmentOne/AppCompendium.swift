//
//  AppCompendium.swift
//  AssignmentOne
//
//  Created by Mark Alford on 7/21/21.
//

import Foundation

//ASSIGNMENT ONE

//MARK: - Patterns
//MVC pattern.
//all logic and data go into a model folder, through methods and properties
//the ViewController ONLY calls these methods

//DELEGATE pattern
//1 the class (delegator) has methods/things it does. but this delegator ALSO has methods it tells other Classes and VCs to do
//2 the methods it TELLS the other classes/structs (delegates) to do are syntaxed like this
    //2.1 delegate?.performProtocolFunc()
//2.1 delegate?.performProtocolFunc() IS THE METHOD that the delegate is told to do by the delegator
//3 this method will also HAVE TO BE IN A PROTOCOL, this protocol is within the same delegator file
//4 within the delegator, make this key. ALL delegates will do the delegator's methods with it
    //4.1 var delegate: ProtocolName?
//4.1 this is the key for the delegate struct/class
//5 within the delegate, in order for it to PERFORM THOSE METHODS OF THE DELEGATOR, have it
    //5.1 take up the protocol, along with func stubs
    //5.2 make var delegator = DelegatorClassName() in top of struct
    //5.3 make delegator.delegate = self within viewDidLoad func
//6 BOOM, now it can delegate!

//TEXTFIELD DELEGATE


//MARK: - Goals
//setup form with TextField, for city or zip code,
//Disable Button on launch, button should be enabled after entering the city or zip code
//setup Weather API and delegate protocol
//setup form functionality to enter zip code or city
//On click for the button, call the below API to fetch forecasted weather details and populate on the same screen (image, temp in C and F)


//MARK: - MVC
//VIEW
//A- setup form and Image Results with constraints for Iphone 8 -done
//B- make sure form UI autolayouts with Ipad -done
//MODEL
//C- setup WeatherAPIManager -done
//D- parse the JSON -done
//CONTROLLER
//H- disable Button on launch -done
//I- connect form UI to form functionality (enable button)
//J- display the Image results


