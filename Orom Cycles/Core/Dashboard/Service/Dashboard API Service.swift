//
//  API Service.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/07/23.
//

import Foundation

class DashboardAPIService {
    
    /// The API URL to get cycles near a coordinate
    static var CYCLES_NEAR_ME_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/cycles/cycles-within/"
    /// Returns the Cycles near me API URL respective to the parameters
    static func get_CYCLES_NEAR_ME_URL(radius: Int, latitude: Double, longitude: Double) -> String {
        return CYCLES_NEAR_ME_URL + "\(radius)/center/\(latitude),\(longitude)"
    }
    
    
    
    /// The API URL to book a cycle (start ride)
    static var START_RIDE_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/cycles/"
    /// Returns the Book Cycle URL for the cycle with the id parameter
    static func get_START_RIDE_URL_OF_CYCLE(cycleId: String) -> String {
        return START_RIDE_URL + cycleId + "/bookings"
    }
    
    /// The API URL to get the active booking
    static var GET_ACTIVE_BOOKING_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/bookings/getMyBooking"
    
    /// The API URL to get the delete booking (end ride)
    static var END_RIDE_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/bookings/"
    /// Returns the End Ride URL for the ride with booking id
    static func get_END_RIDE_URL(bookingId: String) -> String {
        return END_RIDE_URL + bookingId
    }
    
    /// The API URL to get the user info
    static var USER_INFO_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/me"
    
    /// The API URL to update name
    static var UPDATE_NAME_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/updateMe"
    
    /// The API URL to update password
    static var UPDATE_PASSWORD_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/updateMyPassword"
}
