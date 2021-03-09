//
//  ShowFoodViewController.swift
//  LongPress
//
//  Created by Dang Duy Cuong on 3/9/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

class ShowFoodViewController: BaseViewController {
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    var data = Hints()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress))
//        longPress.minimumPressDuration = 0.75
//        longPress.delegate = self
        setupLongPressGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let image = data.food?.image {
            showLoading()
            DispatchQueue.global().async {
                guard let url = URL(string: image) else { return }
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.foodImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ShowFoodViewController.handleLongPress))
        longPress.minimumPressDuration = 0.75
        longPress.delegate = self
        foodImageView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UILongPressGestureRecognizer.State.ended {
            print("tau phuoi")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func tapped(sender: UITapGestureRecognizer)
    {
        print("tapped")
        //Your animation code.
    }

    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
//        sender.minimumPressDuration = 0.75
        if sender.state == UILongPressGestureRecognizer.State.ended {
            print("longpressed")
            //Different code
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}
