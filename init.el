;;; init.el-*- lexical-binding: t; -*-
;; PACKAGES
(add-to-list 'load-path (expand-file-name "init.d/" user-emacs-directory))
(require 'elpaca-setup)
(elpaca-wait)

(elpaca color-theme-sanityinc-tomorrow (load-theme 'sanityinc-tomorrow-night t))
(elpaca goto-chg)
(setq evil-want-keybinding nil)
(elpaca evil (evil-mode t))
(elpaca evil-collection (evil-collection-init))
(elpaca evil-surround (global-evil-surround-mode 1))
(elpaca magit)
(elpaca magit-todos)
(elpaca avy)
(elpaca link-hint)
(elpaca which-key (which-key-mode)
	(setq which-key-popup-type 'side-window
	      which-key-side-window-location '(right bottom)))
(elpaca expand-region)
(elpaca hl-todo (global-hl-todo-mode 1)) ;; TEST TODO
(require 'org-setup)
(require 'minibuffer-setup)
(require 'completion-setup)
(require 'languages-setup)
(elpaca-wait)
;; Packages done

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(line-number-mode 1)
(column-number-mode 1)
(auto-save-mode 0)
(setq tab-always-indent 'complete
      display-line-numbers nil)
(setq-default tab-width 4
              indent-tabs-mode nil)
(global-prettify-symbols-mode 1)
(setq make-backup-files nil
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name ".emacs-auto-saves/" user-emacs-directory) t)))

(evil-set-undo-system 'undo-redo)
(require 'util-functions)
(require 'keybinds)
(require 'safe-local-vars)

;; for fun
(require 'zone)
(elpaca selectric-mode)
