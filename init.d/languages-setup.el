(require 'dash)

(defconst use-tree-sitter (equal system-type 'gnu/linux))

;; multiple programming modes
(mapc (lambda (hook) (add-hook hook #'eglot-ensure))
      '(c++-mode-hook python-mode-hook elixir-mode-hook))
(mapc (lambda (hook)
        (add-hook hook #'display-fill-column-indicator-mode)
        (add-hook hook #'highlight-indent-guides-mode))
      '(c++-mode-hook python-mode-hook elixir-mode-hook emacs-lisp-mode-hook))
(mapc (-lambda ((feature . hook)) 
        `(with-eval-after-load ',feature
          (add-buffer-local-sub-hook ',hook 'before-save-hook #'eglot-format-buffer)))
      '((python . python-mode-hook)))
(elpaca consult-eglot)
;; lisps
(elpaca parinfer-rust-mode)
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
                                (setq tab-width 4)))
  (add-buffer-local-sub-hook 'python-mode-hook 'before-save-hook #'eglot-format-buffer))
;; Elixir
(if use-tree-sitter
    (progn (elpaca elixir-ts-mode)
           (with-eval-after-load 'eglot
             (add-to-list 'eglot-server-programs
                          `((elixir-mode elixir-ts-mode heex-ts-mode) .
                            ,(eglot-alternatives '("language_server.sh" "~/Builds/lexical/_build/dev/package/lexical/bin/start_lexical.sh"))))))
  (elpaca elixir-mode
    (require 'eglot)
    (add-to-list 'eglot-server-programs '(elixir-mode "~/../../Deps/elixir-ls/language_server.bat"))))

;; tree-sitter
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
  (mapc (-lambda ((ts-hook . hook))
          (add-hook ts-hook `(lambda () (run-mode-hooks ',hook))))
        '((c++-ts-mode-hook . c++-mode-hook)
          (python-ts-mode-hook . python-mode-hook)
          (elixir-ts-mode-hook . elixir-mode-hook)))
  (customize-set-variable 'treesit-font-lock-level 3))

(provide 'languages-setup)
