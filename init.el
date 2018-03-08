;;; package --- Summary
;;; Commentary:
;;; code:

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

;; add the elpy package
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)


(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;; packages for python
(defvar myPackages
  '(;; better-defaults
    ein
    elpy
    flycheck
    ;; material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; (when (not package-archive-contents)
;;   (package-refresh-contents))




;; ;; BASIC CUSTOMIZATION
;; ;; --------------------------------------

(prefer-coding-system 'utf-8)

(desktop-save-mode 1)
(require 'desktop-recover) ;; save sessions in desktop file

;; (require 'session)
;; (setq session-save-file (expand-file-name ".session" "~/.emacs.d/desktop"))
;; (setq session-name-disable-regexp "\\(?:\\`'/tmp\\|\\.git/[A-Z_]+\\'\\)")
;; (setq session-save-file-coding-system 'utf-8)

(require 'pair-mode) ;; add pair mode

(require 'autopair)
(autopair-global-mode)

;; (require 'yasnippet)
;; (yas-global-mode 1)



(setq inhibit-startup-message t) ;; hide the startup message
;; (load-theme 'material t) ;; load material theme

;; Show column number
(setq column-number-mode t)
(setq line-number-mode t)
(global-linum-mode t) ;; enable line numbers globally

;; set face
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (virtualenvwrapper jedi py-autopep8 material-theme flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "dim gray" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "DAMA" :family "Ubuntu Mono")))))


;; Starting in fullscreen mode





;; ;; LaTex Configuration
;com; ;; --------------------------------------

;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)

;; So that RefTeX finds my bibliography
(setq reftex-default-bibliography '("/media/ljia/DATA/research-repo/table of graph kernels/graphkernels.bib"))
;; So that RefTeX also recognizes \addbibresource. Note that you
;; can't use $HOME in path for \addbibresource but that "~"
;; works.
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))



;; PYTHON CONFIGURATION
;; --------------------------------------

;; jedi, a python library for contextual parsing of files.
(require 'jedi)
;; hook up to autocomplete
;; (add-to-list 'ac-sources 'ac-source-jedi-direct)
;; enable for python-mode
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'ein)
(require 'ein-loaddefs)
(require 'ein-notebook)
(require 'ein-subpackages)
(elpy-enable)

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt")

;; (add-hook 'elpy-mode-hook (lambda () (elpy-shell-toggle-dedicated-shell 1)))

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; (setq python-shell-completion-native-enable nil)



;; ;; an inferior Python process
;; (defun run-python-once ()
;;   (remove-hook 'python-mode-hook 'run-python-once)
;;   (run-python (python-shell-parse-command)))

;; (add-hook 'python-mode-hook 'run-python-once)


;; ;(setq py-python-command "python3")

;; ;; (temporary)
;; ;; lauch the ipython interpreter wihtout prompt_toolkit, solving freeze problem.
;; (setq python-shell-interpreter "ipython3"
;;       python-shell-interpreter-args "--simple-prompt --pprint")




;; ;; Org Configuration
;; ;; --------------------------------------

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)















;; ;; -*- lexical-binding: t -*-

;; ;;; This file bootstraps the configuration, which is divided into
;; ;;; a number of other files.

;; (let ((minver "24.3"))
;;   (when (version< emacs-version minver)
;;     (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
;; (when (version< emacs-version "24.5")
;;   (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;; (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (require 'init-benchmarking) ;; Measure startup time

;; (defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;; (defconst *is-a-mac* (eq system-type 'darwin))

;; ;;----------------------------------------------------------------------------
;; ;; Adjust garbage collection thresholds during startup, and thereafter
;; ;;----------------------------------------------------------------------------
;; (let ((normal-gc-cons-threshold (* 20 1024 1024))
;;       (init-gc-cons-threshold (* 128 1024 1024)))
;;   (setq gc-cons-threshold init-gc-cons-threshold)
;;   (add-hook 'after-init-hook
;;             (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;; ;;----------------------------------------------------------------------------
;; ;; Bootstrap config
;; ;;----------------------------------------------------------------------------
;; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (require 'init-utils)
;; (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; ;; Calls (package-initialize)
;; (require 'init-elpa)      ;; Machinery for installing required packages
;; (require 'init-exec-path) ;; Set up $PATH

;; ;;----------------------------------------------------------------------------
;; ;; Allow users to provide an optional "init-preload-local.el"
;; ;;----------------------------------------------------------------------------
;; (require 'init-preload-local nil t)

;; ;;----------------------------------------------------------------------------
;; ;; Load configs for specific features and modes
;; ;;----------------------------------------------------------------------------

;; (require-package 'wgrep)
;; (require-package 'project-local-variables)
;; (require-package 'diminish)
;; (require-package 'scratch)
;; (require-package 'command-log-mode)

;; (require 'init-frame-hooks)
;; (require 'init-xterm)
;; (require 'init-themes)
;; (require 'init-osx-keys)
;; (require 'init-gui-frames)
;; (require 'init-dired)
;; (require 'init-isearch)
;; (require 'init-grep)
;; (require 'init-uniquify)
;; (require 'init-ibuffer)
;; (require 'init-flycheck)

;; (require 'init-recentf)
;; (require 'init-smex)
;; (require 'init-ivy)
;; (require 'init-hippie-expand)
;; (require 'init-company)
;; (require 'init-windows)
;; (require 'init-sessions)
;; (require 'init-fonts)
;; (require 'init-mmm)

;; (require 'init-editing-utils)
;; (require 'init-whitespace)

;; (require 'init-vc)
;; (require 'init-darcs)
;; (require 'init-git)
;; (require 'init-github)

;; (require 'init-projectile)

;; (require 'init-compile)
;; ;;(require 'init-crontab)
;; (require 'init-textile)
;; (require 'init-markdown)
;; (require 'init-csv)
;; (require 'init-erlang)
;; (require 'init-javascript)
;; (require 'init-php)
;; (require 'init-org)
;; (require 'init-nxml)
;; (require 'init-html)
;; (require 'init-css)
;; (require 'init-haml)
;; (require 'init-http)
;; (require 'init-python3)
;; (require 'init-haskell)
;; (require 'init-elm)
;; (require 'init-purescript)
;; (require 'init-ruby)
;; (require 'init-rails)
;; (require 'init-sql)
;; (require 'init-rust)
;; (require 'init-toml)
;; (require 'init-yaml)
;; (require 'init-docker)
;; (require 'init-terraform)
;; (require 'init-nix)
;; (maybe-require-package 'nginx-mode)

;; (require 'init-paredit)
;; (require 'init-lisp)
;; (require 'init-slime)
;; (require 'init-clojure)
;; (require 'init-clojure-cider)
;; (require 'init-common-lisp)

;; (when *spell-check-support-enabled*
;;   (require 'init-spelling))

;; (require 'init-misc)

;; (require 'init-folding)
;; (require 'init-dash)
;; (require 'init-ledger)
;; ;; Extra packages which don't require any configuration

;; (require-package 'gnuplot)
;; (require-package 'lua-mode)
;; (require-package 'htmlize)
;; (require-package 'dsvn)
;; (when *is-a-mac*
;;   (require-package 'osx-location))
;; (maybe-require-package 'regex-tool)
;; (maybe-require-package 'dotenv-mode)

;; ;;----------------------------------------------------------------------------
;; ;; Allow access from emacsclient
;; ;;----------------------------------------------------------------------------
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))


;; ;;----------------------------------------------------------------------------
;; ;; Variables configured via the interactive 'customize' interface
;; ;;----------------------------------------------------------------------------
;; (when (file-exists-p custom-file)
;;   (load custom-file))


;; ;;----------------------------------------------------------------------------
;; ;; Allow users to provide an optional "init-local" containing personal settings
;; ;;----------------------------------------------------------------------------
;; (require 'init-local nil t)


;; ;;----------------------------------------------------------------------------
;; ;; Locales (setting them earlier in this file doesn't work in X)
;; ;;----------------------------------------------------------------------------
;; (require 'init-locales)


;; (when (maybe-require-package 'uptimes)
;;   (add-hook 'after-init-hook (lambda () (require 'uptimes))))


(provide 'init)

;; ;; Local Variables:
;; ;; coding: utf-8
;; ;; no-byte-compile: t
;; ;; End:






;; (provide '.emacs)
;;; .emacs ends here
