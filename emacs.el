;; in home directory, 'emacs ~/emacs.el'

;; M-x package-list-packages
;; Ctrl-Alt-x inside lisp command tests the command

(setq inhibit-startup-message t
      ring-bell-function 'ignore ;; gets rid of annoying scrolling noise
      tool-bar-style 'image) ;; has toolbar icons only as images


(global-linum-mode 1) ;; have heard this slows scrolling if many lines

(delete-selection-mode 1) ;; replaces highlighted section with typing

(cua-mode 1)

(setq-default cursor-type 'caret) ;; cursor shape

(global-set-key (kbd "C-a") 'mark-whole-buffer) ;; ctrl a

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(setq frame-title-format
      `((buffer-file-name "%b")))

(setq column-number-mode t)

;; MELPA:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e9d47d6d41e42a8313c81995a60b2af6588e9f01a1cf19ca42669a7ffd5c2fde" "afe5e2fb3b1e295e11c3c22e7d9ea7288a605c110363673987c8f6d05b1e9972" "ed91d4e59412defda16b551eb705213773531f30eb95b69319ecd142fab118ca" default)))
 '(package-selected-packages (quote (ctrlf dakrone-theme cyberpunk-theme clues-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




(defvar themes [\clues \dakrone \cyberpunk])
(defvar r (random 3))
(if (= r 0)
    (load-theme 'clues t)
  (if (= r 1)
      (progn
	(load-theme 'dakrone t)
	(setq themes [\dakrone \cyberpunk \clues]))
    (progn
      (load-theme 'cyberpunk t)
      (setq themes [\cyberpunk \clues \dakrone])
    )
  )
)


;; Theme Button
(defun alec-themes (@n)
  (interactive "p")
  ;; uses a property “state”. Value is a integer.
  (let* (
	 ($values themes)
         ($index-before
          (if (get 'alec-themes 'state)
              (get 'alec-themes 'state) 0))
         ($index-after
	  (% (+ $index-before (length $values) @n)
	     (length $values)))
         ($next-value (aref $values $index-after)))
    (put 'alec-themes 'state $index-after)
    (load-theme $next-value)
    (message "Theme: %s" $next-value)))

(tool-bar-add-item "alec" 'alec-themes
		   '_
		   :help   "Cycle thru themes")
