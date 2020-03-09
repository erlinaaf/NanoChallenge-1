//
//  ViewController.swift
//  NC1Project
//
//  Created by Erlina Fabiola on 03/03/20.
//  Copyright © 2020 Erlina Fabiola. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {

    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
        
    @IBOutlet weak var viewCustom: ButtonCustom!
    
    var activityData = [String]()
    var dateData = [String]()
    var timeData = [String]()
    var locationData = [String]()
    
    var datePicker: UIDatePicker?
    var timePicker: UIDatePicker?
    var activityText = ""
    var dateText = ""
    var timeText = ""
    var locationText = ""
    var swipePosition = 1
    var tempActivity = ""
    var tempDate = ""
    var tempTime = ""
    var tempLocation = ""
    
    //addActivityBtn
    @IBAction func addActivityBtn(_ sender: Any) {
        secondView.isHidden = false
        print("Add Buttton Pressed!")
    }
    
    //backButton
    @IBAction func backBtn(_ sender: Any) {
        print("Back Button Pressed!")
        secondView.isHidden = true
    }
    
    //saveButton
    @IBAction func saveBtn(_ sender: Any) {
        print("Save Button Pressed!")

        if let tempActivity  = activityField.text{
            activityText = tempActivity
        }
        
        if let tempDate = dateField.text{
            dateText = tempDate
        }
        
        if let tempTime = timeField.text{
            timeText = tempTime
        }
        
        if let tempLocation = locationField.text{
            locationText = tempLocation
        }
        
        activityData.append(activityText)
        dateData.append(dateText)
        timeData.append(timeText)
        locationData.append(locationText)
    
        secondView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.isHidden=true
        
        //Day
        let day = DateFormatter()
        day.dateFormat = "EEEE"
        dayLabel.text = day.string(from: Date())
        
        //Date
        let date = DateFormatter();
        date.dateFormat = "MMMM, d YYYY"
        dateLabel.text = date.string(from: Date())
        
        dateInput()
        
        print("View just loaded")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, d YYYY"
        dateField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    
    @objc func timeChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeField.text = timeFormatter.string(from: timePicker.date)
        view.endEditing(true)
    }
    
    func dateInput(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged )

        dateField.inputView = datePicker
               
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
               
        timeField.inputView = timePicker
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
            print("Swipe Left")
            if activityData.count == 0 {
                viewCustom.activityLabel?.text = "Please Input Activity"
            }
            else if swipePosition == activityData.count {
                swipePosition = 1
                setLabel()
                animateViewRight()
            } else if swipePosition < activityData.count {
                swipePosition += 1
                setLabel()
                animateViewRight()
            }
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
            if activityData.count == 0 {
                viewCustom.activityLabel?.text = "Please Input Activity"
            }
            else if swipePosition == 1{
                swipePosition = activityData.count
                setLabel()
                animateViewLeft()
                
            } else if swipePosition > 0 {
                swipePosition -= 1
                setLabel()
                animateViewLeft()
            }
        }
    }
    
    func animateViewRight(){
        UIView.animate(withDuration: 0.08, animations: {
            self.viewCustom.frame.origin.x -= 500
        }, completion: { _ in
            UIView.animate(withDuration: 0, animations: {
                self.viewCustom.frame.origin.x = 555
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    self.viewCustom.frame.origin.x -= 500
                }, completion: { _ in
                    UIView.animate(withDuration: 1, animations: {
                    })
                })
            })
        })
    }
    
    func animateViewLeft(){
           UIView.animate(withDuration: 0.08, animations: {
               self.viewCustom.frame.origin.x += 500
           }, completion: { _ in
            UIView.animate(withDuration: 0, animations: {
                   self.viewCustom.frame.origin.x = -440
                
               }, completion: { _ in
                   UIView.animate(withDuration: 0.3, animations: {
                       self.viewCustom.frame.origin.x += 500
                   }, completion: { _ in
                       UIView.animate(withDuration: 1, animations: {
                       })
                   })
               })
           })
       }
   
    func setLabel(){
        viewCustom.activityLabel?.text = activityData[swipePosition-1]
        viewCustom.timeLabel?.text = timeData[swipePosition-1]
        viewCustom.dateLabel?.text = dateData[swipePosition-1]
        viewCustom.locationLabel?.text = locationData[swipePosition-1]
    }
    
}


