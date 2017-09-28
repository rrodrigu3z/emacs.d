;;; package --- Custom configuration

;;; Commentary:

;;; Code:

;;; Fix locales env vars (eruby problem)
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; Make scrolling smoothier
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Line numbers
(global-linum-mode)
(add-hook 'term-mode-hook (lambda () (linum-mode -1)))
(add-hook 'inf-ruby-mode-hook (lambda () (linum-mode -1)))

;; Typography
(set-face-attribute 'default nil
                    :family "Menlo"
                    :height 120
                    :weight 'normal
                    :width 'normal)
;
(setq-default line-spacing 3
              column-number-mode t
              delete-selection-mode t
              truncate-lines nil)

;; disable lockfiles
;; see http://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html
(setq create-lockfiles nil)
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; autosave the undo-tree history
(setq undo-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq undo-tree-auto-save-history t)

; (toggle-frame-maximized)

; Desktop
; (desktop-save-mode 1)
; (add-hook 'prog-mode-hook 'indent-guide-mode)
; (add-hook 'prog-mode-hook
;           (lambda ()
;             (remove-hook 'indent-guide-mode t)))

;;----------------------------------------------------------------------------
;; Personal config
;;----------------------------------------------------------------------------

;; Themes
(require-package 'twilight-theme)
(require-package 'zenburn-theme)
(require-package 'ir-black-theme)

;; RVM
(require-package 'rvm)
(rvm-use-default)

;; Counsel and ivy
(require-package 'counsel-projectile)
(counsel-projectile-on)
(global-set-key (kbd "M-t") #'counsel-projectile-find-file)
(sanityinc/enable-ivy-flx-matching)

;; Editing
(setq-default cursor-type 'bar)
(global-subword-mode 1)
(setq fci-rule-column 80
      fci-rule-use-dashes nil)
; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
; (global-fci-mode 1)
; (require-package 'column-marker)
; (add-hook 'prog-mode-hook (lambda () (interactive) (column-marker-1 80)))

;;; Taken from https://sriramkswamy.github.io/dotemacs/
(defun sk/open-line-above (args)
  "Insert a new line above the current one or open a new line above for editing"
  (interactive "P")
  (if (equal args '(4))
      (save-excursion
        (unless (bolp)
          (beginning-of-line))
        (newline)
        (indent-according-to-mode))
    (unless (bolp)
      (beginning-of-line))
    (newline)
    (forward-line -1)
    (indent-according-to-mode)))

(defun sk/join-line ()
  "Join the current line with the next line"
  (interactive)
  (next-line)
  (delete-indentation))

(global-set-key (kbd "M-<return>") 'sanityinc/newline-at-end-of-line)
(global-set-key (kbd "M-T") 'imenu)
(global-set-key (kbd "s-SPC") 'just-one-space)
(global-set-key (kbd "M-o") 'sk/open-line-above)
(global-set-key (kbd "M-j") 'sk/join-line)

; Autocomplete
(setq company-minimum-prefix-length 3
      company-idle-delay 0.2)
(setq company-dabbrev-downcase nil)
(require-package 'company-statistics)
(company-statistics-mode)

;; Robe autocompletion adds many methods that are nonsense and useless
(add-hook 'robe-mode-on-hook
          (lambda ()
            (remove-hook 'completion-at-point-functions
                         'robe-complete-at-point t)))

;; Ruby
;; -- GODAMMIT RUBY INDENTATION!!! --
(setq ruby-align-chained-calls 't
      ruby-align-to-stmt-keywords nil
;       ruby-deep-indent-paren nil
;       ruby-deep-indent-paren-style nil
      ruby-use-smie t)

;; Neotree
(require-package 'neotree)
; (global-set-key [f8] 'neotree-toggle)
(setq projectile-switch-project-action 'neotree-projectile-action)

(defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))

(global-set-key [f8] 'neotree-project-dir)
(setq neo-theme 'arrow)
(setq neo-window-position 'left)
(setq neo-window-width 40)

;; Yasnippets
(require 'init-yasnippets)

;; Powerline / Spaceline
;; https://github.com/milkypostman/powerline/issues/54
(setq ns-use-srgb-colorspace nil) ;; Don;t use srgb, fix for powerline

; (require-package 'powerline)
; (powerline-default-theme)
(require-package 'spaceline)
(require 'spaceline-config)
(spaceline-emacs-theme)
; (spaceline-spacemacs-theme)

;; Buffer
(setq clean-buffer-list-delay-general 1)
; (require 'init-midnight)

;; Sessions
;; Needs to be set before enabling desktop-save-mode, moved to init-sessions.el
; (setq desktop-restore-eager 1)

;; Emberjs
(require-package 'handlebars-mode)
; (require-package 'handlebars-sgml-mode)
; (require 'handlebars-sgml-mode)
; (handlebars-use-mode 'minor)

;; CSS
(setq css-indent-offset 2)

;; Git-link
(require-package 'git-link)

;; Tmux management
;; (require-package 'emamux)

;; Multiterm
(require-package 'multi-term)

(provide 'init-local)
;;; init-local.el ends here
