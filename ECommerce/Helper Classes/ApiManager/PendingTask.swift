//
//  PendingTask.swift
//  Amazing Photos
//
//  Created by Atinderpal Singh on 23/11/17.
//  Copyright © 2017 Reliance Jio Infocomm Ltd. All rights reserved.
//

import UIKit

class PendingTask: NSObject {
    var request:URLRequest?
    var completionHandler:RequestCompletionBlock?
}
