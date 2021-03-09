//
//  ViewController.swift
//  LongPress
//
//  Created by Dang Duy Cuong on 3/9/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var listHint = [Hints]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HintTableViewCell.nib(), forCellReuseIdentifier: HintTableViewCell.identifier())
        
        setupLongPressGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        callAPI(responseObject: { [weak self] data in
            if let hints = data.hints {
                self?.listHint = hints
                self?.tableView.reloadData()
            }
        })
    }
    
    func callAPI(responseObject: @escaping(EdamamFoodAndGroceryDatabaseModel) -> ()) {
        let headers = [
            "x-rapidapi-key": "b266514becmsh63278b22c117acfp12ef2cjsn7a142a5dffa4",
            "x-rapidapi-host": "edamam-food-and-grocery-database.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://edamam-food-and-grocery-database.p.rapidapi.com/parser?ingr=apple")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(EdamamFoodAndGroceryDatabaseModel.self, from: data)
                    DispatchQueue.main.async {
                        responseObject(json)
                    }
                } catch { print(error) }
            }
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
        })
        
        dataTask.resume()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHint.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.identifier(), for: indexPath) as! HintTableViewCell
        let data = listHint[indexPath.row]
        cell.data = data
        cell.fillData()
        
        if let image = data.food?.image {
            tableView.beginUpdates()
            cell.foodImageView.dowloadFromServer(link: image)
            tableView.endUpdates()
        }
        
        return cell
    }
    
}

extension ViewController: UIGestureRecognizerDelegate {
    func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress))
        longPress.minimumPressDuration = 0.75
        longPress.delegate = self
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
      if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                self.tableView.deselectRow(at: indexPath, animated: true)
                
                print("dang an o day", indexPath.row)
                let vc = Storyboard.Main.showFoodViewController()
                vc.data = listHint[indexPath.row]
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                present(vc, animated: true, completion: nil)
                self.tableView.reloadData()
            }
        }
    }
}

