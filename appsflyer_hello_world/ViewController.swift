//
//  ViewController.swift
//  appsflyer_hello_world
//
//  Created by user188841 on 2/9/21.
//

import UIKit
import AppsFlyerLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func purchaseButton(_ sender: Any) {
        AppsFlyerLib.shared().useReceiptValidationSandbox = true
        AppsFlyerLib
              .shared()
            .validateAndLog (inAppPurchase: "productIdentifier",
                           price: "100",
                          currency: "USD",
                       transactionId: "1234",
                    additionalParameters: [:],
                          success: {
              guard let dictionary = $0 as? [String:Any] else { return }
              dump(dictionary)
            }, failure: { error, result in
              guard let emptyInApp = result as? [String:Any],
                   let status = emptyInApp["status"] as? String,
                     status == "in_app_arr_empty" else {
                        // Try to handle other errors
                         return
                       }
                 
              // retry with 'SKReceiptRefreshRequest' because
              // Apple has returned an empty response
              // <YOUR CODE HERE>
            })

}
}
