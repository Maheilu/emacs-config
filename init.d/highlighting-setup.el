(elpaca hl-todo (global-hl-todo-mode 1)) ;; TEST TODO
(elpaca highlight-indent-guides
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-auto-enabled nil
        highlight-indent-guides-responsive 'stack)
  (with-eval-after-load 'highlight-indent-guides
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
              highlight-indent-guides-stack-character-face)))))
(provide 'highlighting-setup)
