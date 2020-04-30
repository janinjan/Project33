//
//  Whistle.swift
//  Project33
//
//  Created by Janin Culhaoglu on 30/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    // MARK: - Properties
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
