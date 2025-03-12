(require 'dash)

(defconst use-tree-sitter (equal system-type 'gnu/linux))

;; multiple programming modes
(--map (add-hook it #'eglot-ensure)
       '(c++-mode-hook
         rust-mode-hook
         python-mode-hook
         elixir-mode-hook
         haskell-mode-hook))
(--map (add-hook #'prog-mode-hook it)
       (list #'display-fill-column-indicator-mode
              #'highlight-indent-guides-mode
              #'hs-minor-mode))
(defun push-hook-eglot-format-before-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer 0 'local))
(--map (add-hook it #'push-hook-eglot-format-before-save)
       '(python-mode-hook c++-mode-hook))

;; eglot
(elpaca consult-eglot)
(with-eval-after-load 'eglot (setq eglot-autoshutdown t))

;; C++
(--map (add-to-list 'auto-mode-alist it)
       (list '("\\.cppm\\'" . c++-mode)
             (if use-tree-sitter
                 '("CMakeLists.txt" . cmake-ts-mode)
               '("CMakeLists.txt" . nil))))
(with-eval-after-load 'eglot
  (require 'clangd-setup))
;; emacs lisp
(add-user-hook emacs-lisp-mode-hook
          (add-to-list 'prettify-symbols-alist '("-lambda" . ?Λ)))

;; \LaTeX
(elpaca auctex
  (require 'auctex)
  (setq TeX-parse-self t                ; Enable parse on load.
        TeX-auto-save t)                ; Enable parse on save.
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)
  (--map (add-hook 'LaTeX-mode-hook it)
         (list #'outline-minor-mode
               #'display-fill-column-indicator-mode))
  (when (equal system-type 'gnu/linux)
    (add-hook 'LaTeX-mode-hook #'flyspell-mode)))
;; R
(elpaca ess)
;; Python
(with-eval-after-load 'python
  (setq python-shell-interpreter "ipython3"
        python-shell-interpreter-args "--simple-prompt")
  (add-user-hook python-mode-hook
    (setq-local eglot-report-progress nil)
    ;; python-mode tries really hard to default to 8
    (setq tab-width 4)))
;; Julia
(elpaca julia-mode)
;; Common Lisp
(elpaca sly)
;; Rust
(elpaca rust-mode
  (setq rust-format-on-save t)
  (require 'rust-analyzer-setup))
;; Haskell
(elpaca haskell-mode
  (add-hook 'haskell-mode-hook #'interactive-haskell-mode)
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 (cons '(haskell-mode)
                       '("haskell-language-server-wrapper" "lsp")))))
;; Ada
(elpaca ada-ts-mode
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(ada-ts-mode . "ada_language_server"))))
;; YAML
(elpaca yaml-pro
  (if use-tree-sitter
      (add-hook 'yaml-ts-mode-hook #'yaml-pro-ts-mode)
    (add-hook 'yaml-mode-hook #'yaml-pro-mode))
  (add-to-list 'auto-mode-alist
               (cons "\\.yaml\\'"
                     (if use-tree-sitter
                         #'yaml-ts-mode
                       #'yaml-mode))))
;; GLSL
(elpaca glsl-mode)

;; tree-sitter
(when use-tree-sitter 
  (setq treesit-language-source-alist
        '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (c "https://github.com/tree-sitter/tree-sitter-c")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml"))
        major-mode-remap-alist
        '((c++-mode . c++-ts-mode)
          (c-mode . c-ts-mode)
          (rust-mode . rust-ts-mode)
          (python-mode . python-ts-mode)
          (yaml-pro-mode . yaml-pro-ts-mode)))
  (mapc (-lambda ((ts-hook . hook))
          (add-hook ts-hook `(lambda () (run-mode-hooks ',hook))))
        '((c++-ts-mode-hook . c++-mode-hook)
          (rust-ts-mode-hook . rust-mode-hook)
          (python-ts-mode-hook . python-mode-hook)))
  (customize-set-variable 'treesit-font-lock-level 3))

(provide 'languages-setup)
