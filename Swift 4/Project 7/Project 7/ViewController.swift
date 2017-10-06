//
//  ViewController.swift
//  Project 7
//
//  Created by Javier Jara on 10/6/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UITableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.mainCellIdentifier, for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        
        return cell
    }
        
    
    // MARK: Download Data
    func downloadJSON() {
        let baseUrl = navigationController?.tabBarItem.tag == 0 ? Constants.API.witheHousePetitionURL : Constants.API.witheHousePopularPetitionURL
        
        if let url = URL(string: baseUrl) {
            if let data = try? String(contentsOf: url){
                let json = JSON(parseJSON: data)
                if json[Constants.API.metaDataKey][Constants.API.responseKey][Constants.API.statusKey].intValue == Constants.API.responseOk {
                        // Let's parse
                    parse(json:json)
                    return
                }
            }
        }
        showError()
    }

    func parse(json:JSON){
        for result in json[Constants.API.resultKey].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "laoding error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
        
    }
}

