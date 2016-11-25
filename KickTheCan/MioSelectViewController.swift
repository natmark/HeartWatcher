//
//  MioSelectViewController.swift
//  KickTheCan
//
//  Created by AtsuyaSato on 2016/11/25.
//  Copyright © 2016年 AtsuyaSato. All rights reserved.
//

import UIKit

class MioSelectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    var devices = Array<Dictionary<String, String>>()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DeviceModel.sharedInstance.findMio(completion: { (result: Array<Dictionary<String, String>>) in
            self.devices = result
            self.tableView.reloadData()
        })        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = devices[indexPath.row]["name"]
        return cell
    }
    
    @IBAction func ReloadDevice(_ sender: Any) {
        DeviceModel.sharedInstance.findMio(completion: { (result: Array<Dictionary<String, String>>) in
            self.devices = result
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        DeviceModel.sharedInstance.setMio(serviceId: devices[indexPath.row]["id"]!)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: "GameViewController"), animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
