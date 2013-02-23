(setq stack-trace-on-error t)

;; 启动Emacs Server
(server-start)

;; Key Bindings
;; use C-w to backward kill word, be consistent with Unix shell
(global-set-key "\C-w" 'backward-kill-word)
;; use C-x C-k instead of C-w to kill region
(global-set-key "\C-x\C-k" 'kill-region)
;; use C-h to back delete char as backspace key,
;; be consistent with Unix shell.
;(global-set-key "\C-h" 'backward-delete-char)
;; Use F1 be help.
(global-set-key (kbd "<F1>") 'help-command)
;; F7 Speedbar.
(global-set-key (kbd "<F7>") 'speedbar)


;; Show line numbers.
(global-linum-mode t)
;; Show menu bar.
(menu-bar-mode t)

;; Color theme
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-6.5.5")
(require 'color-theme)
;(color-theme-initialize)
(color-theme-classic)

;; Auto complete
(add-to-list 'load-path "~/.emacs.d/elpa/popup-0.5")
(require 'popup)
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)
(ac-config-default)

;; nxhtml mode for xhtml and php
(load "~/.emacs.d/nxhtml/autostart.el")

;; 
(when (and (equal emacs-major-version 24)
           (equal emacs-minor-version 2))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'interactive-p))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-syntactic-keywords))
  ;; tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function)))