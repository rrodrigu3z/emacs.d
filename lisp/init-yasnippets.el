;;; Install and setup yasnippet

(require-package 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/yasnippet/snippets" ;; main yasnippet snippets
        ;; "~/.emacs.d/plugins/yasnippets-rails/rails-snippets"   ;; rails
        "~/.emacs.d/plugins/ember-snippets"   ;; Emberjs
        "~/.emacs.d/plugins/yasnippet/yasmate/snippets"   ;; yasmate
        "~/.emacs.d/plugins/yasnippet/yasmate/snippets-rails"   ;; yasmate-rails (fix, use ruby-mode)
        ))

; (setq yas-snippet-dirs
;      '("~/.emacs.d/plugins/yasnippet-snippets/snippets"))

; (require 'yasnippet)
; (yas-global-mode 1)
; (yas-reload-all)

(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))
(yas-global-mode 1)

; Rspec snippets
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))
; (add-hook 'prog-mode-hook #'yas-minor-mode)

(provide 'init-yasnippets)
