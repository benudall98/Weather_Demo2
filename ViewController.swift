//
//  ViewController.swift
//  Weather demo
//
//  Created by Clare Udall on 27/07/2016.
//  Copyright © 2016 Clare Udall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var cityTempLabel: UILabel!
    
    @IBAction func getDataButtonClicked(sender: AnyObject) {
        
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(cityNameTextField.text)&APPID=6de03a1d1554874e7594a89fad719dd0")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(data!)
            })
        
        
        }
        task.resume()
        
    }
    
    
     var jsonData: AnyObject?
    
    func setLabels(weatherData: NSData) {
        
        
        do {
            
            self.jsonData = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as! NSDictionary
            
        } catch {
            //error handle here
            
        }
        
        if let name = jsonData!["name"] as? String {
            
            cityNameLabel.text = "\(name)"
            
        }
            
        
        
        if let main = jsonData!["main"] as? NSDictionary {
            if let temp = main["temp"] as? Double {
                cityTempLabel.text = String(format: "%.1f", temp)
            }
        }
    }
    
};

