//
//  ViewController.swift
//  freeland
//
//  Created by VoMinhTuanIOS on 4/12/20.
//  Copyright © 2020 VoMinhTuanIOS. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    var ischeck = true
    let canvas = CanvasView()
    
    let tuanLable:UILabel = {
        let lable = UILabel()
        lable.text = "Võ Minh Tuấn"
        lable.font = .boldSystemFont(ofSize: 20)
        lable.textColor = .white
        lable.backgroundColor = .clear
        return lable
    }()
    let clearButton:UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize:14)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClear(){
        canvas.clear()
    }
    
    let yellowButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 1, alpha: 0.7)
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    let redButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    let blueButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button :UIButton) {
         canvas.setStrokeColor(color: button.backgroundColor ?? .gray)
        ischeck = true
        if ischeck == true {
            yellowButton.backgroundColor = UIColor.white
            redButton.backgroundColor = UIColor.red
            blueButton.backgroundColor = UIColor.blue
        } else {
            yellowButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
            redButton.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            blueButton.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
        }
        ischeck = false
        
    }
    
    let slider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 5
        slider.maximumValue = 15
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleSliderChange() {
        canvas.setStrokeWidth(width: slider.value)
    }
    override func loadView() {
        self.view = canvas
    }
    fileprivate func setutLayout() {
        let tuanStackView = UIStackView (arrangedSubviews: [tuanLable])
        tuanStackView.distribution = .fillEqually
        let colorStackView = UIStackView(arrangedSubviews:[clearButton,yellowButton,redButton,blueButton])
        colorStackView.distribution = .fillEqually
        colorStackView.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews:[
            tuanStackView,
             colorStackView,
             slider
         ])
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        setutLayout()
        
    }
}

