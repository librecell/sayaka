;; client.lisp                                                                                                                                                             

(ql:quickload 'usocket)

(defpackage :simple-client
  (:use :cl :usocket))

(in-package :simple-client)

(defun send-request (message &key (host "127.0.0.1") (port 4051))
  (let ((socket (socket-connect host port)))
    (unwind-protect
         (let* ((stream (socket-stream socket)))
           (format stream "~a~%" message)
           (finish-output stream)
           (let ((response (read-line stream nil)))
             (format t "from sayaka: ~a~%" response)
             response))
      (close socket))))
