//
//  barcodeVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 08.03.2026.
//

import UIKit
import SnapKit

class barcodeVC: UIViewController {
    
    var imgBacrodeCard: UIImage
    private var originalBrightness: CGFloat
    
    lazy var imgViewBarcode: UIImageView = {
      let view = UIImageView()
        view.image = imgBacrodeCard
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        view.addGestureRecognizer(tapGesture)
        //view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        return view
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(closeBarcode))
        return tap
    }()
    
    init(bacrodeCard: UIImage, originalBrightness: CGFloat) {
        self.imgBacrodeCard = bacrodeCard
        self.originalBrightness = originalBrightness
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIScreen.main.brightness = 1.0
        view.addSubview(imgViewBarcode)
        imgViewBarcode.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(view.snp.left).inset(10)
            $0.right.equalTo(view.snp.right).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    

    
    @objc private func closeBarcode() {
        UIScreen.main.brightness = originalBrightness
        dismiss(animated: true)
    }

}
