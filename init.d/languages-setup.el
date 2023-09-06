;; tree-sitter part 1
(if (equal system-type 'gnu/linux)
    (defconst use-tree-sitter t)
  (defconst use-tree-sitter nil))

;; lsp
(mapc (lambda (mode) (add-hook mode #'eglot-ensure))
      '(c++-mode-hook python-mode-hook elixir-mode-hook))
(elpaca consult-eglot)
;; lisps
(elpaca parinfer-rust-mode)
;; R
(elpaca ess)
;; Python
(with-eval-after-load 'python
  (setq python-shell-interpreter "ipython3"
	python-shell-interpreter-args "--simple-prompt")
  (add-hook 'python-mode-hook (lambda () (setq-local eglot-report-progress nil))))
;; Elixir
(if use-tree-sitter
    (elpaca elixir-ts-mode)
  (elpaca elixir-mode))

;; tree-sitter part 2
(when use-tree-sitter 
  (setq treesit-language-source-alist
	    '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
	      (c "https://github.com/tree-sitter/tree-sitter-c")
	      (python "https://github.com/tree-sitter/tree-sitter-python")
	      (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
	      (heex "https://github.com/phoenixframework/tree-sitter-heex"))
	    major-mode-remap-alist
	    '((c++-mode . c++-ts-mode)
	      (c-mode . c-ts-mode)
	      (python-mode . python-ts-mode)
	      (elixir-mode . elixir-ts-mode)))
  (add-hook 'c++-ts-mode-hook (lambda () (run-mode-hooks 'c++-mode-hook)))
  (add-hook 'python-ts-mode-hook (lambda () (run-mode-hooks 'python-mode-hook)))
  (add-hook 'elixir-ts-mode-hook (lambda () (run-mode-hooks 'elixir-mode-hook)))
  (customize-set-variable 'treesit-font-lock-level 3))

(provide 'languages-setup)
