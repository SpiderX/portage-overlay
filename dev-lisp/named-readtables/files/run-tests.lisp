(require "asdf")

(let ((asdf:*user-cache* (uiop:getenv "AUTOPKGTEST_TMP"))) ; Store FASL in some temporary dir
  (asdf:load-system "named-readtables-test"))

;; Can't use ASDF:TEST-SYSTEM, its return value is meaningless
(unless (named-readtables-test::test)
    (uiop:quit 1))
