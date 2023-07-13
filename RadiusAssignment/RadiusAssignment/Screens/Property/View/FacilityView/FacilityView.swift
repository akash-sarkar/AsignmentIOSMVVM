//
//  FacilityView.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 30/06/23.
//

import Foundation
import UIKit

protocol FacilityViewDelegate {
    func didSelect(facilityId: String, optionsID: String)
}

class FacilityView: UIView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var facilities: Facilities? {
        didSet {
            setProperties()
        }
    }
    
    var facilityId: String?
    var delegate: FacilityViewDelegate?
    
    private var optionsArray = [CustomButtonView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FacilityView", owner: self, options: nil)
        containerView.fixInView(self)
        cardView.backgroundColor = .black
        cardView.layer.cornerRadius = 15
    }
    
    private func setProperties() {
        self.facilityId = facilities?.facility_id
        
        titleLbl.text = facilities?.name
        titleLbl.textColor = .white
        
        guard let options = facilities?.options else { return }

        for option in options {
            let optionView = CustomButtonView()
            optionView.options = option
            optionView.delegate = self
            optionsArray.append(optionView)
            optionsStackView.addArrangedSubview(optionView)
        }
    }
    
    func disSelect(optionsID: String){
        for array in optionsArray {
            if array.getId() == optionsID {
                array.setButtonStatus(isSelected: false)
            }
        }
    }
}

extension FacilityView: CustomButtonViewDelegate {
    func isSelectedButton(id : String, isSelected: Bool) {
        if isSelected {
            guard let facilityId = facilityId else { return }
            delegate?.didSelect(facilityId: facilityId, optionsID: id)
            
            for options in optionsArray {
                if id != options.getId() {
                    options.setButtonStatus(isSelected: false)
                }
            }
        }
    }
}
