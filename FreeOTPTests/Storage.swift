//
// FreeOTP
//
// Authors: Nathaniel McCallum <npmccallum@redhat.com>
//
// Copyright (C) 2015  Nathaniel McCallum, Red Hat
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import FreeOTP
import XCTest

class Storage: XCTestCase {
    func test() {
        let def = UserDefaults.standard
        def.set(["baz:bar"] as [String], forKey: "tokenOrder")
        def.set("otpauth://hotp/foo:bar?secret=JBSWY3DPEHPK3PXP&issuer=baz", forKey: "baz:bar")
        def.synchronize()

        let ts = TokenStore()
        XCTAssertGreaterThan(ts.count, 0)

        let token = ts.load(0)
        XCTAssertNotNil(token)
        XCTAssertEqual(token!.issuer, "foo")
        XCTAssertEqual(token!.label, "bar")
        _ = ts.erase(token: token!)

        XCTAssertNil(def.stringArray(forKey: "tokenOrder"))
        XCTAssertNil(def.string(forKey: "baz:bar"))
    }
}
