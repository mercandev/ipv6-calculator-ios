//
//  ResultViewController.swift
//  IpV6Calculator
//
//  Created by Kaan Mercan on 8.12.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var ipaddressResult: UITextField!
    @IBOutlet weak var totalIpAddress: UITextField!
    @IBOutlet weak var network: UITextField!
    @IBOutlet weak var broadcatAddress: UITextField!
    
    var items:ResponseV6Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ipaddressResult.text = items?.data?.ipAddress!
        totalIpAddress.text = items?.data?.size
        network.text = items?.data?.firstIPAddress!
        broadcatAddress.text = items?.data?.lastIPAddress!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
