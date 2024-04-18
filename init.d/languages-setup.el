(require 'dash)

(defconst use-tree-sitter (equal system-type 'gnu/linux))

;; multiple programming modes
(mapc (lambda (hook)
        (add-hook hook #'eglot-ensure))
      '(c++-mode-hook rust-mode-hook python-mode-hook
        elixir-mode-hook haskell-mode-hook))
(mapc (lambda (hook)
        (add-hook hook #'display-fill-column-indicator-mode)
        (add-hook hook #'highlight-indent-guides-mode)
        (add-hook hook #'hs-minor-mode))
      '(c++-mode-hook rust-mode-hook python-mode-hook
        elixir-mode-hook emacs-lisp-mode-hook haskell-mode-hook))
(mapc (lambda (hook) (add-buffer-local-sub-hook hook 'before-save-hook #'eglot-format-buffer))
      '(python-mode-hook c++-mode-hook))
(elpaca consult-eglot)
;; C++
(mapc (lambda (assoc)
        (add-to-list 'auto-mode-alist assoc))
      (list '("\\.cppm\\'" . c++-mode)
            (if use-tree-sitter
                '("CMakeLists.txt" . cmake-ts-mode)
              nil)))
(with-eval-after-load 'eglot
  (require 'clangd-setup))
;; lisps
(elpaca parinfer-rust-mode)
(mapc (lambda (hook)
        (add-hook hook #'parinfer-rust-mode))
      '(emacs-lisp-mode-hook lisp-interaction-mode-hook))
;; emacs lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda () (add-to-list 'prettify-symbols-alist '("-lambda" . ?Λ))))
;; R
(elpaca ess)
;; Python
(with-eval-after-load 'python
  (setq python-shell-interpreter "ipython3"
        python-shell-interpreter-args "--simple-prompt")
  (add-hook 'python-mode-hook (lambda ()
                                (setq-local eglot-report-progress nil)
                                ;; python tries really hard to default to 8
                                (setq tab-width 4))))
;; Rust
(elpaca rust-mode
  (setq rust-format-on-save t)
  (require 'rust-analyzer-setup))
;; Haskell
(elpaca haskell-mode (add-hook 'haskell-mode-hook #'interactive-haskell-mode))

;; tree-sitter
(when use-tree-sitter 
  (setq treesit-language-source-alist
        '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (c "https://github.com/tree-sitter/tree-sitter-c")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (rust "https://github.com/tree-sitter/tree-sitter-rust"))
        major-mode-remap-alist
        '((c++-mode . c++-ts-mode)
          (c-mode . c-ts-mode)
          (rust-mode . rust-ts-mode)
          (python-mode . python-ts-mode)
          (elixir-mode . elixir-ts-mode)))
  (mapc (-lambda ((ts-hook . hook))
          (add-hook ts-hook `(lambda () (run-mode-hooks ',hook))))
        '((c++-ts-mode-hook . c++-mode-hook)
          (rust-ts-mode-hook . rust-mode-hook)
          (python-ts-mode-hook . python-mode-hook)
          (elixir-ts-mode-hook . elixir-mode-hook)))
  (customize-set-variable 'treesit-font-lock-level 3))

(provide 'languages-setup)
