//
//  PropertyViewModel.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 29/06/23.
//

import Foundation

final class PropertyViewModel {
    private var property: PropertyModel?
    var facilities = [Facilities]()
    var exclusion = [[Exclusions]]()
    
    var eventHandler: ( (_ event: Event) -> Void)?
    
    func fetchDataFromAPI() {
        eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let property):
                self.property = property
                self.setFaclilities()
                self.setExclusion()
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    private func setFaclilities() {
        guard let property = property else { return }
        
        guard let porpertyFacilities = property.facilities else { return }
        
        for facility in porpertyFacilities {
            facilities.append(facility)
        }
    }
    
    private func setExclusion() {
        guard let property = property else { return }
        
        guard let exclusionArr = property.exclusions else { return }
        
        for element in exclusionArr {
            exclusion.append(element)
        }
    }
}

extension PropertyViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
