;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;    GLOBAL    ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 启动Emacs Server
(require 'server)
(or (server-running-p)
    (server-start))

;; Disable auto-fill-mode
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; Show line numbers.
(global-linum-mode t)
;; Show menu bar.
(menu-bar-mode t)

;; Fullcreen for Linux
(defun my-fullscreen ()
 (interactive)
 (x-send-client-message
  nil 0 nil "_NET_WM_STATE" 32
  '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;    KEYS    ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;; F8 switch between actionscript mode and nxml mode
;(global-set-key (kbd "<f8>") 'actionscript-mode)
;(global-set-key (kbd "<S-f8>") 'xml-mode)
;(global-set-key (kbd "<S-f8>") 'nxml-mode)
;; F11 to toggle maxmize the window
(global-set-key [f11] 'my-fullscreen)
;; use C-tab to do auto complete
(global-set-key [C-tab] 'auto-complete)

;; 各窗口间切换  
(global-set-key (kbd "C-x <C-left>") 'windmove-left)  
(global-set-key (kbd "C-x <C-right>") 'windmove-right)  
(global-set-key (kbd "C-x <C-up>") 'windmove-up)  
(global-set-key (kbd "C-x <C-down>") 'windmove-down)  




;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;    PLUGINS    ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Color theme
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-6.5.5")
(require 'color-theme)
(color-theme-calm-forest)

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

;; turn on soft wrapping mode for org mode
(add-hook 'org-mode-hook
  (lambda () (setq truncate-lines nil)))

;; nxhtml mode for xhtml and php
;(load "~/.emacs.d/nxhtml/autostart.el")

;; Change to use 4 spaces for tab in HTML mode.
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (turn-off-auto-fill)
            (setq indent-tabs-mode t)))

;; Enable yasnippet globally.
(yas-global-mode 1)

;; Less CSS mode
;(add-to-list 'load-path "~/.emacs.d/site-lisp/less-css-mode")
;(add-to-list 'load-path "~/.emacs.d/elpa/less-css-mode-0.18")
;(require 'less-css-mode)

;; Flymake
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-checkers-0.2")
(require 'flymake-checkers)
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-cursor-1.0.2")
(require 'flymake-cursor)
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-easy-0.9")
(require 'flymake-easy)

;; Use jshint to validate JS codes
(add-to-list 'load-path "~/git/jshint-mode")
(require 'flymake-jshint)
(add-hook 'js-mode-hook
          (lambda () (flymake-mode t)))
;; jslint
;; (add-to-list 'load-path "~/.emacs.d/elpa/flymake-jslint-0.10")
;; (require 'flymake-jslint)
;; (add-hook 'js-mode-hook 'flymake-jslint-load)

;; CMD Mode 
(add-to-list 'load-path "~/.emacs.d/site-lisp/cmd-mode")
(require 'cmd-mode)
(add-to-list 'auto-mode-alist '("\\.cmd\\'" . cmd-mode))

;; Flymake cursor
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-cursor")
;(require 'flymake-cursor)

;; markdown mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Enable Zen Coding.
(add-to-list 'load-path  "~/Public/git/zencoding/")
(require 'zencoding-mode)

;; Mustache mode - A good web template language.
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'mustache-mode)

;; actionscript mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/actionscript-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete-actionscript")
(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)
;(eval-after-load "actionscript-mode" '(load "actionscript-config"))
(when (require 'actionscript-mode nil t)
  (setq auto-mode-alist
        (append '(("\\.as$" . actionscript-mode))
                auto-mode-alist)))
;; (setq nxml-mode-hook
;;       '(lambda ()
;;          (setq tab-width        4
;;                indent-tabs-mode nil)
;;          (set-variable 'nxml-child-indent     4)
;;          (set-variable 'nxml-attribute-indent 4)
;;          ))
;; -------------------------------------------------------------------
;; Imenu for actionscript
;; -------------------------------------------------------------------
(add-hook 'actionscript-mode-hook 'imenu-add-menubar-index)
(add-hook 'actionscript-mode-hook 'actionscript-init-imenu)
(defun actionscript-init-imenu ()
  (interactive)
  (setq imenu-generic-expression as-imenu-as-generic-expression)
  (global-set-key [mouse-3] 'imenu))

(defvar as-imenu-as-generic-expression
  ` (
     ("variables"
      ,(concat
        "^" ; line MUST start with word char
        "[ \t]*\\(public\\|protected\\|mx_internal\\|private\\)"
        "[ \t]+var"
        "[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)" ; match function name
        "[ \t]*:\\([a-zA-Z_][a-zA-Z0-9_]*\\)"
        ), 2)
     ;; Getters
     ("Getters"
      ,(concat
        "^" ; line MUST start with word char
        "[ \t]*\\(override[ \t\n]+\\)?" ; no parentheses before
        "[ \t]*\\(public\\|protected\\|mx_internal\\|private\\)"
        "[ \t]+function"
        "[ \t]+"
        "\\(get[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]*\\)()" ; getter
        ) 3)
     ;;setters
     ("setters"
      ,(concat
        "^" ; line MUST start with word char
        "[ \t]*\\(override[ \t\n]+\\)?" ; no parentheses before
        "[ \t]*\\(public\\|protected\\|mx_internal\\|private\\)"
        "[ \t]+function"
        "[ \t]+"
        "\\(set[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t]*\\)" ; setter
        "("
        "\\([a-zA-Z_][a-zA-Z0-9_]*\\):\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \t\n]*"
        ")"
        ) 3)

     ;; Class definitions
     (nil
      ,(concat
        "^" ; beginning of line is required
        "\\(\\(public\\|protected\\|mx_internal\\|private\\)[ \t]+\\)?"
        "\\(class\\|interface\\)[ \t]+"
        "\\(" ; the string we want to get
        "[a-zA-Z0-9_]+" ; class name
        "\\)"
        "[ \t\n]*"
        "\\(extends [ \t\n]*[a-zA-Z0-9_]+\\)?"
        "[ \t\n]*";;[:{]"
        "\\(implements [ \t\n]*\\([a-zA-Z0-9_]+[,][ \t\n]*\\)*[a-zA-Z0-9_]\\)?"
        "[ \t\n]*";;[:{]"
        ) 4)

     ;; General function name regexp
     (nil
      ,(concat
        "^" ; line MUST start with word char
        "[ \t]*\\(override[ \t\n]+\\)?" ; no parentheses before
        "[ \t]*\\(public\\|protected\\|mx_internal\\|private\\)"
        "\\([ \t]+static\\)?" ; no parentheses before
        "[ \t]+function"
        "[ \t]+\\([a-zA-Z_][a-zA-Z0-9_]*\\)" ; match function name
        "[ \t]*("
        "[^)]*)"
        ) 4)
     )
    "Imenu generic expression for C++ mode. See `imenu-generic-expression'.")



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
