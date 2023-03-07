

import Foundation


func logInfo(_ message: String, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    if (showLog) {
        print("\(function): \(line): \(message)")
    }
}

func logInfo(_ message: Any, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    if (showLog) {
        print("\(function): \(line): \(message)")
    }
}

func getlogInfo(_ message: String, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) ->String {
    if (showLog) {
        let str = "\(function): \(line): \(message)"
        return str
    }
    return ""
}
