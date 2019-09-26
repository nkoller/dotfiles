(defconst windows-gui? (eq system-type 'windows-nt))


;; Package stuff

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))

(require 'use-package)
(setq
  use-package-always-defer t
  use-package-always-ensure t)


;; Evil

(use-package evil
  :init (evil-mode t)
  :after (evil-leader)
  :config
  (setq evil-default-cursor t)
  (global-linum-mode))

(use-package evil-leader
  :init (global-evil-leader-mode)
  :config
  (evil-leader/set-leader "SPC")
    (evil-leader/set-key
      "h" 'windmove-left
      "j" 'windmove-down
      "k" 'windmove-up
      "l" 'windmove-right
      
      "H" (lambda () (interactive) (split-window-horizontally))
      "J" (lambda () (interactive) (split-window-vertically) (windmove-down))
      "K" (lambda () (interactive) (split-window-vertically))
      "L" (lambda () (interactive) (split-window-horizontally) (windmove-right))
      
      "-" 'shrink-window
      "=" 'enlarge-window
      "[" 'shrink-window-horizontally
      "]" 'enlarge-window-horizontally
      	
      "w" 'delete-window
      "q" 'kill-buffer
      "TAB" 'switch-to-buffer
      
      "SPC" 'shell
      "f" 'find-file
      "p" 'projectile-commander
      "ein" 'ein:login))


;; Shell

(if windows-gui?
  (setq explicit-shell-file-name "C:/Windows/System32/bash.exe"))


;; Appearance

(if windows-gui?
  (use-package one-themes
               :init
               (load-theme 'one-dark t)))

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(setq visible-bell 1)


;; Extensions

(use-package powerline
	     :init (powerline-default-theme))

(use-package projectile
  :init (projectile-mode 1)
  :config
  (setq projectile-project-search-path
        (if windows-gui?
          '("C:/Users/nadav/Documents/Code")
          '("/u5/nkoller/os161"))) ;; Project folder on university machine
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package ein
  :ensure t)
