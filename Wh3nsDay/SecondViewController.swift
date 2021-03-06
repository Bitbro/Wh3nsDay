//
//  SecondViewController.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/15/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SecondViewController: UIViewController {
    private var currentDate = Date()
    private var currentMonthString = ""
    private var currentMonthInt = 0
    private var year = 2019
    private var monthLabel = UILabel()
    private var numberOfDaysInMonth = [Int]()
    private var modList = [Int]() // modlist is used to calculate the offset when modList % 7 -d

    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfDaysInMonth.append(31) // creates array of days in month based on 2019, in 2020 it will still work -d
        numberOfDaysInMonth.append(28)
        numberOfDaysInMonth.append(31)
        numberOfDaysInMonth.append(30)
        numberOfDaysInMonth.append(31)
        numberOfDaysInMonth.append(30)
        numberOfDaysInMonth.append(31)
        numberOfDaysInMonth.append(31)
        numberOfDaysInMonth.append(30)
        numberOfDaysInMonth.append(31)
        numberOfDaysInMonth.append(30)
        numberOfDaysInMonth.append(31)
        currentMonthString = getMonthFromDate(date: currentDate) // used current date so no matter when u use this app it will start off on the current month and year - d
        setMonthLabel()
        setYearLabel()
        leapYearTestandSetup() // test if leap year and shifts offset bases on year - d
        setup(dayInt: 1, offset: offsetCalculator(), numberOfDays: numberOfDaysInMonth[currentMonthInt]) // sets up view
        
    }
    
    @IBAction func nextMonth(_ sender: Any) { // when swiped right it shows the next month - d
        currentMonthInt = currentMonthInt + 1
        
        view.subviews.forEach({ $0.removeFromSuperview() }) //  clears screen - d
        if (currentMonthInt == 12){ // cycles trrough and changes year - d
            year = year + 1
            currentMonthInt = 0
        }
        setStringFromInt() //sets vars
        monthLabel.text = currentMonthString // changes the month user sees - d
        leapYearTestandSetup()
        setup(dayInt: 1, offset: offsetCalculator(), numberOfDays: numberOfDaysInMonth[currentMonthInt])
        modList[currentMonthInt] = offsetCalculator()
        
        setMonthLabel()
        print(year)
        print(currentMonthInt)
        print(currentMonthString)
        
    }
    func offsetCalculator() -> Int{
        return (57 * (modList[currentMonthInt] % 7) + (year - 2018) % 7) // each day is 57  units away so this calcumlates where each "1st" of the month should be - d
    }
    @IBAction func lastMonth(_ sender: Any) { // same as next month but backwards - d
        currentMonthInt = currentMonthInt - 1
        view.subviews.forEach({ $0.removeFromSuperview() })
        if (currentMonthInt == -1){
            year = year - 1
            currentMonthInt = 11
        }
        if(currentMonthInt == 2 && year % 4 == 0){
            setup(dayInt: 1, offset: 57*0, numberOfDays: 29)
        }
        setStringFromInt()
        monthLabel.text = currentMonthString
        leapYearTestandSetup()
        setup(dayInt: 1, offset: offsetCalculator(), numberOfDays: numberOfDaysInMonth[currentMonthInt])
        modList[currentMonthInt] = offsetCalculator()
        setMonthLabel()
    }
    
    
    func getMonthFromDate(date: Date)-> String{ //sets month data from a date obj
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let currentMonthString = dateFormatter.string(from: now)
        if(currentMonthString == "January"){
            currentMonthInt = 0
            print(1)
        }else if(currentMonthString == "February"){
            currentMonthInt = 1
            print(2)
        }else if(currentMonthString == "March"){
            currentMonthInt = 2
            print(currentMonthInt)
        }else if(currentMonthString == "April"){
            currentMonthInt = 3
            print(currentMonthInt)
        }else if(currentMonthString == "May"){
            currentMonthInt = 4
            print(currentMonthInt)
        }else if(currentMonthString == "June"){
            currentMonthInt = 5
            print(currentMonthInt)
        }else if(currentMonthString == "July"){
            currentMonthInt = 6
            print(currentMonthInt)
        }else if(currentMonthString == "August"){
            currentMonthInt = 7
            print(currentMonthInt)
        }else if(currentMonthString == "September"){
            currentMonthInt = 8
            print(currentMonthInt)
        }else if(currentMonthString == "October"){
            currentMonthInt = 9
            print(currentMonthInt)
        }else if(currentMonthString == "November"){
            currentMonthInt = 10
            print(currentMonthInt)
        }else if(currentMonthString == "December"){
            currentMonthInt = 11
            print(currentMonthInt)
        }
        return(currentMonthString)
    }
    func setMonthLabel(){
        monthLabel.frame = CGRect(x: 207, y: 50, width: 200, height: 50)
        monthLabel.center.x = self.view.center.x
        monthLabel.text = currentMonthString
        monthLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 38)
        monthLabel.textColor = UIColor.blue
        monthLabel.textAlignment = NSTextAlignment.center
        monthLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //monthLabel.highlightedTextColor = UIColor.green
        monthLabel.isHighlighted = false
        monthLabel.isUserInteractionEnabled = true
        monthLabel.isEnabled = true
        monthLabel.numberOfLines = 0
        monthLabel.adjustsFontSizeToFitWidth = true
        monthLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.view.addSubview(monthLabel)
    }
    func setYearLabel(){
        let yearLabel = UILabel()
        yearLabel.frame = CGRect(x: 207, y: 100, width: 100, height: 30)
        yearLabel.center.x = self.view.center.x
        yearLabel.text = String(year)
        yearLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 38)
        yearLabel.textColor = UIColor.blue
        yearLabel.textAlignment = NSTextAlignment.center
        yearLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        yearLabel.isHighlighted = false
        yearLabel.isUserInteractionEnabled = true
        yearLabel.isEnabled = true
        yearLabel.numberOfLines = 0
        yearLabel.adjustsFontSizeToFitWidth = true
        yearLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.view.addSubview(yearLabel)
    }
    func setDayLabel(){
        let dayLabel = UILabel()
        dayLabel.frame = CGRect(x: 207, y: 200, width: 500, height: 30)
        dayLabel.center.x = self.view.center.x
        let space = String("     ")
        dayLabel.text = ("S" + space + "M" + space + "T" + space + "W" + space + "T" + space + "F" + space + "S")
        dayLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
        dayLabel.textColor = UIColor.blue
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.center.x = dayLabel.center.x - 2
        dayLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //dayLabel.highlightedTextColor = UIColor.green
        dayLabel.isHighlighted = false
        dayLabel.isUserInteractionEnabled = true
        dayLabel.isEnabled = true
        dayLabel.numberOfLines = 0
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.view.addSubview(dayLabel)
    }
    func createAddEventButton(){ // button that changes to add view controller - d
        let addEventBtn = UIButton(type: .custom)
        addEventBtn.frame = .init(x: 207, y: 800, width: 100, height: 60)
        addEventBtn.setTitle("Add Event", for: .normal)
        addEventBtn.backgroundColor = UIColor.blue
        addEventBtn.center.x = self.view.center.x
        addEventBtn.layer.cornerRadius = 15
        addEventBtn.layer.borderColor = UIColor.black.cgColor
        addEventBtn.layer.borderWidth = 1
        addEventBtn.layer.masksToBounds = true
        addEventBtn.addTarget(self, action: #selector(addEventSwitch(e: )), for: .touchUpInside)
        self.view.addSubview(addEventBtn)
    }
    @objc func addEventSwitch(e: Int){ // is the method that moves to add view controller
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "addEventView") as! ViewController
        self.present(homeView, animated: false, completion: nil)
    }
    func setup(dayInt: Int, offset: Int, numberOfDays: Int){ //RECURSIVE METHOD - d
        if dayInt > numberOfDays { // when all days r made it stops
            createAddEventButton()
            setYearLabel()
            setDayLabel()
            return
        }
        let offsetX = offset % 399
        let offsetY = Int((offset/399)) * 70
        let dayString =  String(dayInt)
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 10+offsetX, y: 250 + offsetY, width: 55, height: 60)
        btn.setTitle(dayString, for: .normal)
        if(hasEvent(stringYear : (String(year)+"-"+String(adjInt(int: currentMonthInt+1))+"-"+String(adjInt(int: dayInt))))){
            btn.backgroundColor = UIColor.red
            } else {
            btn.backgroundColor = UIColor.blue
            }
        btn.layer.cornerRadius = 15
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        addTarget(btn: btn, dayInt: dayInt) // calls add event with button argument - d
        setup(dayInt: dayInt + 1, offset: offset + 57, numberOfDays: numberOfDays )
    }
    
    func hasEvent(stringYear:String) -> Bool {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "eventListView") as! ThirdViewController
        var eventforDay = homeView.getEventDay(n:stringYear)
        var date  = homeView.strToDate(dayString: stringYear)
        eventforDay = homeView.filter(eventsFull: eventforDay, day: date)
        if(eventforDay.count > 0){
            return true
        }
        return false
    }
    
    @objc func addTarget(btn: UIButton, dayInt: Int) { // unfortunatly when adding a target to a button you can not pass an argument so i have to use if's to see what the target of the button should be - d
        if dayInt == 1 {
            btn.addTarget(self, action: #selector(pressed1(dayInt: )), for: .touchUpInside)
        }else if dayInt == 2 {
            btn.addTarget(self, action: #selector(pressed2(dayInt: )), for: .touchUpInside)
        }else if dayInt == 3 {
            btn.addTarget(self, action: #selector(pressed3(dayInt: )), for: .touchUpInside)
        }else if dayInt == 4 {
            btn.addTarget(self, action: #selector(pressed4(dayInt: )), for: .touchUpInside)
        }else if dayInt == 5 {
            btn.addTarget(self, action: #selector(pressed5(dayInt: )), for: .touchUpInside)
        }else if dayInt == 6 {
            btn.addTarget(self, action: #selector(pressed6(dayInt: )), for: .touchUpInside)
        }else if dayInt == 7 {
            btn.addTarget(self, action: #selector(pressed7(dayInt: )), for: .touchUpInside)
        }else if dayInt == 8 {
            btn.addTarget(self, action: #selector(pressed8(dayInt: )), for: .touchUpInside)
        }else if dayInt == 9 {
            btn.addTarget(self, action: #selector(pressed9(dayInt: )), for: .touchUpInside)
        }else if dayInt == 10 {
            btn.addTarget(self, action: #selector(pressed10(dayInt: )), for: .touchUpInside)
        }else if dayInt == 11{
            btn.addTarget(self, action: #selector(pressed11(dayInt: )), for: .touchUpInside)
        }else if dayInt == 12 {
            btn.addTarget(self, action: #selector(pressed12(dayInt: )), for: .touchUpInside)
        }else if dayInt == 13 {
            btn.addTarget(self, action: #selector(pressed13(dayInt: )), for: .touchUpInside)
        }else if dayInt == 14 {
            btn.addTarget(self, action: #selector(pressed14(dayInt: )), for: .touchUpInside)
        }else if dayInt == 15 {
            btn.addTarget(self, action: #selector(pressed15(dayInt: )), for: .touchUpInside)
        }else if dayInt == 16 {
            btn.addTarget(self, action: #selector(pressed16(dayInt: )), for: .touchUpInside)
        }else if dayInt == 17 {
            btn.addTarget(self, action: #selector(pressed17(dayInt: )), for: .touchUpInside)
        }else if dayInt == 18 {
            btn.addTarget(self, action: #selector(pressed18(dayInt: )), for: .touchUpInside)
        }else if dayInt == 19 {
            btn.addTarget(self, action: #selector(pressed19(dayInt: )), for: .touchUpInside)
        }else if dayInt == 20 {
            btn.addTarget(self, action: #selector(pressed20(dayInt: )), for: .touchUpInside)
        }else if dayInt == 21 {
            btn.addTarget(self, action: #selector(pressed21(dayInt: )), for: .touchUpInside)
        }else if dayInt == 22 {
            btn.addTarget(self, action: #selector(pressed22(dayInt: )), for: .touchUpInside)
        }else if dayInt == 23 {
            btn.addTarget(self, action: #selector(pressed23(dayInt: )), for: .touchUpInside)
        }else if dayInt == 24 {
            btn.addTarget(self, action: #selector(pressed24(dayInt: )), for: .touchUpInside)
        }else if dayInt == 25 {
            btn.addTarget(self, action: #selector(pressed25(dayInt: )), for: .touchUpInside)
        }else if dayInt == 26 {
            btn.addTarget(self, action: #selector(pressed26(dayInt: )), for: .touchUpInside)
        }else if dayInt == 27 {
            btn.addTarget(self, action: #selector(pressed27(dayInt: )), for: .touchUpInside)
        }else if dayInt == 28 {
            btn.addTarget(self, action: #selector(pressed28(dayInt: )), for: .touchUpInside)
        }else if dayInt == 29 {
            btn.addTarget(self, action: #selector(pressed29(dayInt: )), for: .touchUpInside)
        }else if dayInt == 30 {
            btn.addTarget(self, action: #selector(pressed30(dayInt: )), for: .touchUpInside)
        }else if dayInt == 31 {
            btn.addTarget(self, action: #selector(pressed31(dayInt: )), for: .touchUpInside)
        }
        
    } // all the below methods are the destinations of the above targets - d
    @objc func pressed1(dayInt: Int){openDay(dayInt: 1)}
    @objc func pressed2(dayInt: Int){openDay(dayInt: 2)}
    @objc func pressed3(dayInt: Int){openDay(dayInt: 3)}
    @objc func pressed4(dayInt: Int){openDay(dayInt: 4)}
    @objc func pressed5(dayInt: Int){openDay(dayInt: 5)}
    @objc func pressed6(dayInt: Int){openDay(dayInt: 6)}
    @objc func pressed7(dayInt: Int){openDay(dayInt: 7)}
    @objc func pressed8(dayInt: Int){openDay(dayInt: 8)}
    @objc func pressed9(dayInt: Int){openDay(dayInt: 9)}
    @objc func pressed10(dayInt: Int){openDay(dayInt: 10)}
    @objc func pressed11(dayInt: Int){openDay(dayInt: 11)}
    @objc func pressed12(dayInt: Int){openDay(dayInt: 12)}
    @objc func pressed13(dayInt: Int){openDay(dayInt: 13)}
    @objc func pressed14(dayInt: Int){openDay(dayInt: 14)}
    @objc func pressed15(dayInt: Int){openDay(dayInt: 15)}
    @objc func pressed16(dayInt: Int){openDay(dayInt: 16)}
    @objc func pressed17(dayInt: Int){openDay(dayInt: 17)}
    @objc func pressed18(dayInt: Int){openDay(dayInt: 18)}
    @objc func pressed19(dayInt: Int){openDay(dayInt: 19)}
    @objc func pressed20(dayInt: Int){openDay(dayInt: 20)}
    @objc func pressed21(dayInt: Int){openDay(dayInt: 21)}
    @objc func pressed22(dayInt: Int){openDay(dayInt: 22)}
    @objc func pressed23(dayInt: Int){openDay(dayInt: 23)}
    @objc func pressed24(dayInt: Int){openDay(dayInt: 24)}
    @objc func pressed25(dayInt: Int){openDay(dayInt: 25)}
    @objc func pressed26(dayInt: Int){openDay(dayInt: 26)}
    @objc func pressed27(dayInt: Int){openDay(dayInt: 27)}
    @objc func pressed28(dayInt: Int){openDay(dayInt: 28)}
    @objc func pressed29(dayInt: Int){openDay(dayInt: 29)}
    @objc func pressed30(dayInt: Int){openDay(dayInt: 30)}
    @objc func pressed31(dayInt: Int){openDay(dayInt: 31)}
   
    func openDay(dayInt: Int){ // changes story board and  passes the date to use -d
        print(dayInt)
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "eventListView") as! ThirdViewController
        let s = String(year) + "-" + adjInt(int: currentMonthInt + 1) + "-" + adjInt(int: dayInt)
        homeView.setCurrentDateInString(d: s)
        print(s)
        self.present(homeView, animated: false, completion: nil)
    }
    func adjInt(int: Int) -> String{ // if day is "5" i need it to be "05"
        var stringInt = String(int)
        if(stringInt.count == 1){
            stringInt = "0" + stringInt
        }
        return stringInt
    }
    
    func setStringFromInt(){
        if(currentMonthInt == 0){
            currentMonthString = "January"
        }else if(currentMonthInt == 1){
            currentMonthString = "February"
        }else if(currentMonthInt == 2){
            currentMonthString = "March"
        }else if(currentMonthInt == 3){
            currentMonthString = "April"
        }else if(currentMonthInt == 4){
            currentMonthString = "May"
        }else if(currentMonthInt == 5){
            currentMonthString = "June"
        }else if(currentMonthInt == 6){
            currentMonthString = "July"
        }else if(currentMonthInt == 7){
            currentMonthString = "August"
        }else if(currentMonthInt == 8){
            currentMonthString = "September"
        }else if(currentMonthInt == 9){
            currentMonthString = "October"
        }else if(currentMonthInt == 10){
            currentMonthString = "November"
        }else if(currentMonthInt == 11){
            currentMonthString = "December"
        }
    }
    func leapYearTestandSetup(){
        modList.removeAll() // clears modlis - d
        if(year % 4 == 0){ // checks for leap year - d
            numberOfDaysInMonth[1] = 29
        } else{
            numberOfDaysInMonth[1] = 28
        }
        var i = 0
        while i < 12 {
            if(i == 0){
                modList.append((year-2017)) // in 2017 offset = 0 - d
            }else{
                modList.append(((modList[i-1]) + (numberOfDaysInMonth[i-1]) % 7) % 7) // calc offset -d
            }
            print(modList[i] )
            i = i + 1
            //
        }
    }
}

