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



;; ;; BASIC CUSTOMIZATION
;; ;; --------------------------------------

(prefer-coding-system 'utf-8)

(desktop-save-mode 1)
(require 'desktop-recover) ;; save sessions in desktop file

(require 'pair-mode) ;; add pair mode

(require 'autopair)
(autopair-global-mode)

(require 'helm-config) 

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
    (virtualenvwrapper jedi py-autopep8 flycheck elpy ein))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "dim gray" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "DAMA" :family "Ubuntu Mono")))))



;; LaTex Configuration
;; --------------------------------------

;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)

;; So that RefTeX finds my bibliography
(setq reftex-default-bibliography '("/media/ljia/DATA/research-repo/publications/bibs/graphkernels.bib"))
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



;; ;; Org Configuration
;; ;; --------------------------------------

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)



(provide 'init)

;; ;; Local Variables:
;; ;; coding: utf-8
;; ;; no-byte-compile: t
;; ;; End:
