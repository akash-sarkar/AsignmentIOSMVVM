//
//  CustomButtonView.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 30/06/23.
//

import Foundation
import UIKit

protocol CustomButtonViewDelegate {
    func isSelectedButton(id: String, isSelected: Bool)
}

class CustomButtonView: UIView{
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var radioBtn: UIButton!
    var options: Option? {
        didSet {
            setProperties()
        }
    }
    
    var delegate: CustomButtonViewDelegate?
    
    private var id: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomButtonView", owner: self, options: nil)
        containerView.fixInView(self)
        containerView.layer.cornerRadius = 15
        bgBtn.layer.cornerRadius = 15
    }
    
    private func setProperties() {
        id = options?.id
        titleLbl.text = options?.name
        iconImage.image = UIImage(named: options?.icon ?? "rooms")
        radioBtn.setImage(UIImage(named: "radio_btn"), for: .normal)
        radioBtn.setImage(UIImage(named: "radio_btn_selected"), for: .selected)
    }
    
    func setButtonStatus(isSelected: Bool) {
        radioBtn.isSelected = isSelected
    }
    func getId() -> String {
        return id ?? ""
    }
    
    private func buttonAction() {
        radioBtn.isSelected = !radioBtn.isSelected
        delegate?.isSelectedButton(id: id ?? "", isSelected: radioBtn.isSelected)
    }
    @IBAction func radioBtnAction(_ sender: Any) {
        buttonAction()
    }
    @IBAction func bgButtonAction(_ sender: Any) {
        buttonAction()
    }
}
