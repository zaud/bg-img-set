;;;;
;;;; back graund image set (Xwindow system)
;;;; using ImageMagick(display)
;;;;

(defparameter base-imgf-dir "/home/zaud6/Kabegami/")

(defmacro base-add (str)
  `(concatenate 'string base-imgf-dir ,str))

(defvar main-imgf-dir "")
(defvar season-imgf-dir "")

(let ((mon (fifth (multiple-value-list (get-decoded-time))))
      (spring    (base-add "Spring/"))
      (summer    (base-add "Summer/"))
      (autumn    (base-add "Autumn/"))
      (winter    (base-add "Winter/"))
      (newyear   (base-add "NewYear/"))
      (tuyu      (base-add "Tuyu/"))
      (halloween (base-add "Halloween/"))
      (xmas      (base-add "Xmas/")))
  (cond
   ((< mon 3)  (setf season-imgf-dir winter))
   ((< mon 6)  (setf season-imgf-dir spring))
   ((< mon 9)  (setf season-imgf-dir summer))
   ((< mon 12) (setf season-imgf-dir autumn))
   (t (setf season-imgf-dir winter)))
  (cond
   ((eq mon 1) (setf main-imgf-dir newyear))
   ((eq mon 6) (setf main-imgf-dir tuyu))
   ((eq mon 10)(setf main-imgf-dir halloween))
   ((eq mon 12)(setf main-imgf-dir xmas))
   (t (setf main-imgf-dir base-imgf-dir))))


(defun get-img-list (dir)
  (mapcan #'(lambda (ext) 
              (directory
                (concatenate 'string dir "*." ext)))
    '("jpg" "gif" "png")))


(let* ((lst (concatenate 'list
         (get-img-list main-imgf-dir)
         (get-img-list season-imgf-dir)))
       (n (length lst))
       (img (namestring (nth (random n (make-random-state t)) lst)))
       (arg (list
         "display" "-window" "root" "-background" "black" "-backdrop" img)))
  (sb-ext:run-program "/usr/local/bin/display" arg))

