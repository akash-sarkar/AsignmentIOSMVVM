//
//  PropertyViewController.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 29/06/23.
//

import UIKit

class PropertyViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var topLbl: UILabel!
    
    private var viewModel = PropertyViewModel()
    
    private var facilityViewList = [FacilityView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
    }
}

extension PropertyViewController {
    private func setProperties(){
        topLbl.text = "Property"
        topLbl.font = UIFont.systemFont(ofSize: 25)
        viewModel.fetchDataFromAPI()
        bindData()
    }
    
    private func bindData() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("loading event")
            case .stopLoading:
                print("stop loading event")
            case .dataLoaded:
                print("data loaded")
                DispatchQueue.main.async {
                    self.setFacilities()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
    
    private func setFacilities() {
        for facilities in viewModel.facilities {
            let facilityView = FacilityView()
            facilityView.facilities = facilities
            facilityView.delegate = self
            facilityViewList.append(facilityView)
            mainStackView.addArrangedSubview(facilityView)
        }
    }
    
    private func setExclusions(facilityId: String, optionsID: String) {
        for exclusions in viewModel.exclusion {
            var foundExclusion = false
            for exclusion in exclusions {
                if exclusion.facility_id == facilityId && exclusion.options_id == optionsID {
                    foundExclusion = true
                }
            }
            
            if foundExclusion {
                for exclusion in exclusions {
                    if exclusion.facility_id != facilityId && exclusion.options_id != optionsID {
                        notifyExclusions(facilityId: exclusion.facility_id ?? "", optionsID: exclusion.options_id ?? "")
                    }
                }
            }
        }
    }
    
    private func notifyExclusions(facilityId: String, optionsID: String) {
        for facilitiesObj in facilityViewList {
            if facilitiesObj.facilityId == facilityId {
                facilitiesObj.disSelect(optionsID: optionsID)
            }
        }
    }
}

extension PropertyViewController: FacilityViewDelegate {
    func didSelect(facilityId: String, optionsID: String) {
        print("facility ID: \(facilityId)  optionsId: \(optionsID)")
        setExclusions(facilityId: facilityId, optionsID: optionsID)
    }
}
