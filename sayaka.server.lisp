;; server.lisp                                                                                                                                                             

(ql:quickload 'usocket)

(defpackage :simple-server
  (:use :cl :usocket))

(in-package :simple-server)

(defun handle-client (socket)
  (unwind-protect
       (let* ((stream (socket-stream socket))
              (request (read-line stream nil)))
         (format t "received request: ~a~%" request)
         (let ((response (format nil "from ~a" request)))
           (format stream "~a~%" response)
           (finish-output stream)))
    (close socket)))

(defun start-server (&key (port 4051))
  (let ((server-socket (socket-listen "127.0.0.1" port :reuse-address nil)))
    (format t "sayaka server started on port ~A~%" port)
    (loop
      (let ((client-socket (socket-accept server-socket)))
        (format t "sayaka client connected~%")
        (handle-client client-socket)))))

(defun fucking-do-like-everything ()
  (sb-thread:make-thread #'start-server))

(defun stop-server (server-socket)
  (close server-socket)
  (format t "sayaka server stopped~%"))
