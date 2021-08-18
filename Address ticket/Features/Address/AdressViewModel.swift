//
//  AdressViewModel.swift
//  Address ticket
//
//  Created by Pedro Léda on 21/07/21.
//
import Foundation

final class AdressViewModel{
    
    // MARK: Properties
     var ticket: AddressModel!
    
    // MARK: Methods
    func validateCep(input: String?) -> Bool {
        guard let input = input else { return false }

        return NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-s]?\\d{3})$")
            .evaluate(with: input.uppercased())
    }
    
    func createTicket(name: String,
                      cep: String,
                      address: String,
                      number: String,
                      complement: String,
                      neighborhood: String,
                      city:String,
                      state: String) -> AddressModel {
        
        ticket = AddressModel(name: name,
                     cep: cep,
                     address: address,
                     number:number,
                     complement:complement,
                     neighborhood: neighborhood,
                     city: city,
                     state: state)
        return ticket
    }
}
