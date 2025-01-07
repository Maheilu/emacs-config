(elpaca hl-todo
  ;; TODO TEST\ TEST INCOMPLETE.!?:wa=SD
  (global-hl-todo-mode 1)
  ;; apparently this color is called tyrian purple
  (add-to-list 'hl-todo-keyword-faces '("INCOMPLETE" . "#630330")) 
  ;; im sending you to ultramar
  (add-to-list 'hl-todo-keyword-faces '("CHECK" . "#0437F2")) 
  ;; highlight characters following keyword
  (setq hl-todo-highlight-punctuation ":!?._()=1-9a-zA-Z+---\s"))
(elpaca highlight-indent-guides
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-auto-enabled nil
        highlight-indent-guides-responsive 'stack)
  (defun set-highlight-indent-guides-faces ()
    (interactive)
    (require 'highlight-indent-guides)
    (require 'outline)
    (let ((normal (face-foreground 'fill-column-indicator))
          (top (face-foreground 'outline-2))
          (stack (face-foreground 'outline-1)))
      (mapc (lambda (face) (set-face-foreground face normal))
            '(highlight-indent-guides-odd-face
              highlight-indent-guides-even-face
              highlight-indent-guides-character-face))
      (mapc (lambda (face) (set-face-foreground face top))
            '(highlight-indent-guides-top-odd-face
              highlight-indent-guides-top-even-face
              highlight-indent-guides-top-character-face))
      (mapc (lambda (face) (set-face-foreground face stack))
            '(highlight-indent-guides-stack-odd-face
              highlight-indent-guides-stack-even-face
              highlight-indent-guides-stack-character-face))))
  (add-hook 'enable-theme-hook #'set-highlight-indent-guides-faces)
  (add-hook 'highlight-indent-guides-mode-hook #'set-highlight-indent-guides-faces))

(provide 'highlighting-setup)
