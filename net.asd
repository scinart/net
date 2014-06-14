(asdf:defsystem :net
  :description "a simple wrapper of dramka"
  :version "0.1"
  :author "Scinart O <akubeej@gmail.com>"
  :license "BSD 2-Clause License"
  :depends-on ("drakma"
	       "st-json"
	       "cl-ppcre"
	       "closure-html"
	       "babel"
	       "split-sequence")
  :components ((:file "net")
	       ))

