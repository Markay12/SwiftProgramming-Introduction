//
//  SplashScreenViewContoller.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a delay to simulate loading time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Transition to the main view controller
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
            self.present(mainVC, animated: true, completion: nil)
        }
    }
}

