;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utilities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use spaces instead of indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; use clipboard
(setq x-select-enable-clipboard t)
;; show parentheses matches
(show-paren-mode t)
;; no startup page
(setq inhibit-startup-message t)
;; 显示列号
(global-linum-mode 1)
;(setq column-number-mode t)
;(setq line-number-mode t)
;; 启动Emacs Server
(server-start)
;; set folder for auto-save
(setq
   backup-by-copying t ; 自动备份
   backup-directory-alist '(("." . "~/.saves")) ; 自动备份在目录"~/.saves"下
   delete-old-versions t ; 自动删除旧的备份文件
   kept-new-versions 6 ; 保留最近的6个备份文件
   kept-old-versions 2 ; 保留最早的2个备份文件
   version-control t) ; 多次备份
;; turn on soft wrapping mode for org mode
(add-hook 'org-mode-hook
 (lambda () (setq truncate-lines nil)))

;; short for yes and no answers.
(fset 'yes-or-no-p 'y-or-n-p)
;; no tool bar and menu bar and scroll bar
(tool-bar-mode nil)
(menu-bar-mode nil)
(scroll-bar-mode nil)

;; enable ido mode ;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utilities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global bing key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use C-x C-m instead of M-x to execute extended command
(global-set-key "\C-x\C-m" 'execute-extended-command)
;; use C-w to backward kill word, be consistent with Unix shell
(global-set-key "\C-w" 'backward-kill-word)
;; use C-x C-k instead of C-w to kill region
(global-set-key "\C-x\C-k" 'kill-region)
;; use C-h to back delete char as backspace key,
;; be consistent with Unix shell.
(global-set-key "\C-h" 'backward-delete-char)
;; use Win-h instead of C-h
;;(global-set-key (kbd "<f1>") 'help-command)
;; Band key F6 to run shell command
(global-set-key (kbd "<f6>") 'shell-command)
;; use C-tab to do auto complete 
(global-set-key [C-tab] 'auto-complete)
;(global-set-key [C-tab] 'complete-tag)
;; 各窗口间切换  
(global-set-key (kbd "C-x <C-left>") 'windmove-left)  
(global-set-key (kbd "C-x <C-right>") 'windmove-right)  
(global-set-key (kbd "C-x <C-up>") 'windmove-up)  
(global-set-key (kbd "C-x <C-down>") 'windmove-down)  

(global-set-key [f11] 'my-fullscreen)
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)
(my-fullscreen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global bing key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 颜色主题
(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)

;; javascript mode
;(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))
(add-to-list 'load-path "~/.emacs.d/js2")
;;(require 'js2)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; flymake-jslint 
(add-to-list 'load-path "~/.emacs.d/flymake-jslint/")
(require 'flymake-jslint)
(add-hook 'js-mode-hook
      (lambda () (flymake-mode t)))


;; auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)
;(ac-config-default)

;; nxhtml mode for xhtml and php
(load "~/.emacs.d/nxhtml/autostart.el")


;; PHP mode
(setq load-path (cons "~/.emacs.d/php-mode" load-path))
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; php auto complete
(add-to-list 'load-path "~/.emacs.d/php/")
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/php/")
(require 'php-mode)
(add-hook 'php-mode-hook
          (lambda()
            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-c p") 'phpcmp-complete)
            (when (require 'auto-complete nil t)
              (make-variable-buffer-local 'ac-sources)
              (add-to-list 'ac-sources 'ac-source-php-completion)
              (auto-complete-mode t))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;(load-file "~/.emacs.d/cedet/common/cedet.el")
;;
;; Enable EDE (Project Management) features
;(global-ede-mode 1)
;;
;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")
;;
;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:
;;
;; * This enables the database and idle reparse engines
;(semantic-load-enable-minimum-features)
;;
;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;(semantic-load-enable-code-helpers) 
;;
;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)
;;
;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)
;;
;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ECB: Emacs Code Browser
;(add-to-list 'load-path "~/.emacs.d/ecb")
;(require 'ecb)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-to-list 'load-path
              "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)
(add-to-list 'ac-sources 'ac-source-yasnippet)



;(let ((buffer (url-retrieve-synchronously
;	       "http://tromey.com/elpa/package-install.el")))
;  (save-excursion
;    (set-buffer buffer)
    ;; (goto-char (point-min))
    ;; (re-search-forward "^$" nil 'move)
    ;; (eval-region (point) (point-max))
    ;; (kill-buffer (current-buffer))))


;; Jabber
(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0")
(require 'jabber-autoloads)
;; set account for gtalk
(setq jabber-account-list
  '(("zhengchubo@gmail.com"
;  '(("justin.zhengyi.wu@gmail.com"
     (:network-server . "talk.google.com")
     (:connection-type . ssl))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "SteelBlue" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 138 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(put 'dired-find-alternate-file 'disabled nil)
