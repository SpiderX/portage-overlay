(require "asdf")

(asdf:load-system "fiveam")
(asdf:load-system "cl-ansi-text.test")
(fiveam:run! :cl-ansi-text)
