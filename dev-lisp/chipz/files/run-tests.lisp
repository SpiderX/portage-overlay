(require "asdf")

(let ((asdf:*user-cache* (uiop:getenv "AUTOPKGTEST_TMP"))) ; Store FASL in some temporary dir
  (asdf:load-system "chipz"))
