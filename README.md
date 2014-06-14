description
======
net is a simple and handy wrapper of common lisp package dramka.

usage
======
use quicklisp to load this package.

    (ql:quickload :net)
    ;; get raw content
    (defvar raw-content (net:wget "http://some.url.com/"))
    ;; use [Closure HTML](http://common-lisp.net/project/closure/closure-html/) to parse
    (defvar list-content (net:parse raw-content))
    ;; select your content.
    (defvar useful (net:find-node list-content
                                  #'(lambda (x) (and (listp x)
                                               (eq :div (first x))))
                                  #'third))
    ;; now useful is the collection of content of outermost <div>.

example
======

First it is super simple that I suggest you read the source code.

[Crawl Example](http://scinart.github.io/lisp/2014/06/14/common-lisp-simple-crawl/#toc4)

[cookies or post](http://scinart.github.io/lisp/2014/06/14/common-lisp-simple-crawl/#toc5)

gbk encoding:  
(babel:octets-to-string (net:wget url) :encoding :gbk)

recommand packages
======

;; very good json library
;; (ql:quickload :st-json)
;; GBK codec facility
;; (ql:quickload :babel)
;; regular expression library
;; (ql:quickload :cl-ppcre)

license
======
BSD 2-Clause License.

