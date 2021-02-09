;;; pre-load stuff
(setq evil-want-C-u-scroll t)

;;; packages 
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
   '("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "e7f49a69d5fed5597d37b0711ca195fd632b9b08993194cb2f1d36dd1f7b20a0" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "2c613514f52fb56d34d00cc074fe6b5f4769b4b7f0cc12d22787808addcef12c" "c0a0c2f40c110b5b212eb4f2dad6ac9cac07eb70380631151fa75556b0100063" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" default))
 '(org-agenda-files '("~/Org/organizer.org"))
 '(package-selected-packages
   '(no-littering org-journal general smex magit fontawesome mood-line evil-commentary smart-mode-line which-key undo-tree counsel projectile evil))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#1b212f" :foreground "#c3c0bb" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 151 :width normal :foundry "nil" :family "Menlo")))))

;;; random settings
;; (setq mouse-drag-copy-region t)
(setq void-text-area-pointer 'text)
(setq org-startup-folded nil)        ;;; org outline expanded
;; (setq org-blank-before-new-entry '((heading . t) (plain-list-item . auto)))        ;;; set blanks between headers on insert
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
(setq org-default-notes-file "~/Org/organizer.org")
(setq ring-bell-function 'ignore)
(which-key-mode)
(evil-commentary-mode)        ;;; gcc to comment lines in evil mode
;;; Tell Emacs where is your personal theme directory
(add-to-list 'custom-theme-load-path (expand-file-name "themes"
                                                       user-emacs-directory))
(set-face-attribute 'default nil :family "Menlo" :height 150 :weight 'normal)
(menu-bar-showhide-tool-bar-menu-customize-disable)
(unless (display-graphic-p)
   (menu-bar-mode -1))
(savehist-mode 1)
(setq help-window-select t)

;;; evil
(evil-mode 1)

;;; no loitering
(require 'no-littering)

;;; define maps
(defvar my-leader-map (make-sparse-keymap) "Keymap for <leader> key")
(defvar my-org-map (make-sparse-keymap) "Keymap for my org files")

;;; define leader key
(define-key evil-normal-state-map (kbd "SPC") my-leader-map)

;;; define leader key bindings
(define-key my-leader-map "i" (defun open-init () (interactive) (find-file user-init-file)))
(define-key my-leader-map "o" my-org-map)
(define-key my-leader-map (kbd "SPC") (defun prev-buffer () (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))
(define-key my-leader-map "." 'find-file)
(define-key my-leader-map "," 'switch-to-buffer)
(define-key my-leader-map "k" 'kill-buffer)
(define-key my-leader-map "p" 'projectile-command-map)
(define-key my-leader-map "g" 'magit-dispatch)
(define-key my-leader-map "o" my-org-map)

;;; define my custom org key map
(define-key my-org-map "o" (defun find-in-org-dir () (interactive) (counsel-find-file "~/Org/")))
(define-key my-org-map "z" (defun go-to-organizer () (interactive) (find-file "~/Org/organizer.org")))
;; (define-key my-org-map "n" 'org-journal-new-entry)
(define-key my-org-map "j" 'org-journal-new-entry)
(define-key my-org-map "m" (lambda () (interactive) (org-journal-new-entry t)))

;;; random key bindings
(define-key evil-insert-state-map "\C-g" 'evil-normal-state)
(global-set-key (kbd "s-=") 'text-scale-increase)        ;;; set cmd +/- to resize text  
(global-set-key (kbd "s--") 'text-scale-decrease)
(setq org-M-RET-may-split-line '((default . nil)))

;;; org journal settings
(setq org-journal-find-file #'find-file)
(setq org-journal-file-format "%Y-%m-%d")
(setq org-journal-date-prefix "#+TITLE: ")
(setq org-journal-date-format (concat "%A, %B %d %Y\n"
				      ;; "#+STARTUP: showall\n"
                                      "\n"
				      "* Tasks\n"))
(setq org-journal-time-prefix "** ")
(setq org-journal-time-format "")
(setq org-journal-hide-entries-p nil)
(setq org-journal-dir "~/Org/journal/")
(require 'org-journal)

;;; undo
(require 'undo-tree)
(global-undo-tree-mode)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
(define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)

;;; projectile
(require 'projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/Projects"))
(setq projectile-switch-project-action 'projectile-dired)
(projectile-mode +1)

;;; set theme directory
(setq custom-theme-directory "~/.emacs.d/themes")
(load-theme 'ayu-grey t)

;;; ivy
(ivy-mode 1)
(counsel-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-initial-inputs-alist nil)

;;; fix mac cmd-v cmd-p copy/paste
(require 'simpleclip)
(simpleclip-mode 1)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;;; mood line
(mood-line-mode)
