;;; package --- Summary
;;; Commentary:
;;; customized by Francesco Pischedda
(require 'package)

;;; Code:
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(show-paren-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(define-key global-map (kbd "C-c ;") 'iedit-mode)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ( add-to-list 'load-path "~/.emacs.d/use-package")
  (require 'use-package))


(use-package zenburn-theme
  :ensure t
  :init (load-theme 'zenburn t))

(use-package magit
  :ensure t
  :config (global-set-key (kbd "C-x g") 'magit-status))

(use-package yasnippet
  :ensure t
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode 1))

(use-package powerline
  :ensure t
  :config (powerline-default-theme))

(use-package ivy
  :ensure t)

(use-package elpy
  :ensure t
  :init
  (setq elpy-rpc-backend "jedi")
  :config
  (elpy-enable)
  (yas-minor-mode)
  (jedi:setup))

(projectile-global-mode)

(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  (slime-mode t))

(use-package ox-reveal
  :ensure t
  :init
  (setq org-reveal-root "file:///Users/francescopischedda/reveal.js/"))

;; run multi-term pressing F1
(global-set-key [f1] 'multi-term)

(use-package rainbow-delimiters
  :ensure t
  :config (rainbow-delimiters-mode))

(use-package paredit
  :ensure t
  :config (paredit-mode))

(use-package clojure-mode
  :ensure t
  :init
;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)
;; When there's a cider error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")
;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)
  ;;:config
;; provides minibuffer documentation for the code you're typing into the repl
  ;;(cider-turn-on-eldoc-mode)
  )

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljc.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; A little more syntax highlighting
(use-package clojure-mode-extra-font-locking
  :ensure t)

(use-package org
  :ensure t)

; ORG mode customizations
(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :ensure t
  :config (org-bullets-mode 1))

; redifine some modeline
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")
(rename-modeline "clojure-mode" clojure-mode "Clj")
(rename-modeline "python-mode" python-mode "Py")

;; flycheck stuff
(add-hook 'after-init-hook #'global-flycheck-mode)

; a fix needed to run ipython4 as a shell inside emacs
; link: https://www.reddit.com/r/Python/comments/4w5d4e/psa_ipython_5_will_break_emacs_heres_how_to_fix_it/
(setq python-shell-interpreter "ipython"
  python-shell-interpreter-args "--simple-prompt")

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (paredit-mode zenburn-theme web-mode tagedit slime-clj slime rainbow-delimiters pylint projectile powerline-evil ox-reveal org-bullets multi-term magit-popup jedi-direx ivy helm golint go-complete go-autocomplete go git-commit flycheck-pyflakes exec-path-from-shell evil-surround erlang elpy elixir-yasnippets elixir-mix django-mode darkokai-theme cython-mode column-marker column-enforce-mode clojure-mode-extra-font-locking clj-refactor calfw-gcal calfw android-mode alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
