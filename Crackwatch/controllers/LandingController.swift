//
//  LandingController.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import UIKit

class LandingController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startAnimation()
  }
  
  private func startAnimation() {
    UIView.animate(withDuration: 0.2, animations: { [weak self] in
      self?.activityIndicator.startAnimating()
    }, completion: { [weak self] _ in
      self?.stopAnimation()
    })
  }
  
  private func stopAnimation() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
      UIView.animate(withDuration: 0.2, animations: {
        self?.activityIndicator.stopAnimating()
      }, completion: { _ in
        self?.toMain()
      })
    })
  }
  
  private func toMain() {
    let mainCoordinator = GameListCoordinator(presentedController: self)
    mainCoordinator.presentMain()
  }
}
