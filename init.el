
;; Keybinding changes for convenience
(setq ns-command-modifier 'control) ;; change "C" in emacs to command key 
(global-set-key (kbd "M-3") (lambda () (interactive) (insert "#"))) ;; make option 3 return the hash/pound symbol
(global-set-key (kbd "C-/") 'comment-dwim) ;; set ctrl/command forward slash for commenting


;;configure some emacs minor mode
(column-number-mode) ;;add line numbering to emacs 
(global-display-line-numbers-mode) ;; Enable global line numbers
(dolist (mode '(org-mode-hook term-mode-hook shell-mode-hook eshell-mode-hook treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))) ;; Disable line numbers in specific modes
(tool-bar-mode -1) ;;turn off toolbar and menubar


;; Remove word wrapping and allow scorlling horizontally
(setq-default truncate-lines t) ; Prevent line wrapping globally
(setq truncate-partial-width-windows t) ; Also prevent wrapping in split windows
(setq hscroll-margin 1)         ; Start scrolling horizontally when the cursor is 1 column from the edge
(setq hscroll-step 1)           ; Scroll 1 column at a time
(setq auto-hscroll-mode 'current-line) ; Automatically scroll horizontally for the current line


;; set up theme
(setq modus-themes-italic-constructs t        ; Enable italics for emphasis
      modus-themes-bold-constructs t        ; Enable bold text
      modus-themes-region '(bg-only no-extend) ; Selection with only background color
      modus-themes-syntax '(faint)           ; Use subtle syntax highlighting
      modus-themes-paren-match '(intense)    ; Highlight matching parentheses
      modus-themes-links '(neutral-underline faint) ; Make links subtle
      modus-themes-prompts '(subtle)         ; Subtle prompts in minibuffer
      modus-themes-org-blocks 'gray-background ; Neutral background for Org blocks
      modus-themes-mode-line '(accented))   ; Modern, less intrusive mode-line


(setq modus-vivendi-palette-overrides
      '((bg-main "#101216")
	(fg-main "#76B8FC")
	(bg-line-number-inactive "#101216")
	(keyword "#f9736A")
	(string "#c6daff")
	(builtin "#c6daff")
	(preprocessor "#ff7f86")
	(type "#c6daff")
	(constant blue-cooler)
	(delimiter fg-main)
	(docmarkup magenta-faint)
	(docstring "#989898")
	(fnname "#ffffff")
	(variable "#76B8FC")
	(comment "#989898")))

(load-theme 'modus-vivendi t)                 ; Load Modus Vivendi
;; "#ffffff"
;;  "#76B8FC"


;; font size
(set-face-attribute 'default nil :height 150)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq-local face-remapping-alist '((default :height 180)))))


 
;;initialize packages
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;;initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))



(require 'use-package)
(setq use-package-always-ensure t)

;; set package for rainbow parenthesis 
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ;; package that autocomplete key bindings
;; (use-package which-key
;;   :config
;;   (setq which-key-idle-delay 1.0)
;;   (which-key-mode))

;; (use-package ivy
;;   :ensure t
;;   :diminish
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))

;; ;; Enable counsel-mode for additional ivy-based commands
;; (use-package counsel
;;   :ensure t
;;   :after ivy
;;   :config
;;   (counsel-mode 1))

;;  ;; Enable ivy-rich for enhanced display
;; (use-package ivy-rich
;;   :ensure t
;;   :after (ivy counsel)  ;; Load after both ivy and counsel
;;   :config
;;   (ivy-rich-mode 1))

;; (ivy-mode)


;; ;;load themes for emacs
;; (use-package modus-themes
;;   :ensure nil
;;   :custom
;;   (modus-themes-italic-constructs t)        ; Enable italics for emphasis
;;   (modus-themes-bold-constructs t)        ; Enable bold text
;;   (modus-themes-region '(bg-only no-extend)) ; Selection with only background color
;;   (modus-themes-syntax '(faint))           ; Use subtle syntax highlighting
;;   (modus-themes-paren-match '(intense))    ; Highlight matching parentheses
;;   (modus-themes-links '(neutral-underline faint)) ; Make links subtle
;;   (modus-themes-prompts '(subtle))         ; Subtle prompts in minibuffer
;;   (modus-themes-org-blocks 'gray-background) ; Neutral background for Org blocks
;;   (modus-themes-mode-line '(accented))   ; Modern, less intrusive mode-line
;;   ;; (modus-themes-common-palette-overrides
;;   ;;  '((bg-main "#000000")        ; Grayish background
;;   ;;    (comment "#001f1a")))
;;   :init
;;   (load-theme 'modus-vivendi t))  
					; Load Modus Vivendi



;; (keyword . "#5F87FF")        ; Bluish keywords
;; (string . "#FFA500")         ; Orange strings
;; (name . "#FFD700")))         ; Gold for function names   







;; org mode edits
(defun uo/org-mode-setup ()
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . uo/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun uo/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . uo/org-mode-visual-fill))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block ((t (:background "#1e1e1e" :extend t))))
 '(org-block-background ((t (:background "#1e1e1e" :extend t))))
 '(org-block-begin-line ((t (:background "#2e2e2e" :foreground "#888888" :extend t))))
 '(org-block-end-line ((t (:background "#2e2e2e" :foreground "#888888" :extend t))))
 '(org-code ((t (:background "#1e1e1e" :extend t :inherit fixed-pitch))))
 '(org-meta-line ((t (:background "#2e2e2e" :foreground "#888888" :extend t))))
 '(org-table ((t (:background "#1e1e1e" :extend t :inherit fixed-pitch)))))



;; Enable programming languages in Org Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

;; Set Python interpreter to python3
(setq org-babel-python-command "python3")

;; Disable confirmation prompts for code execution
(setq org-confirm-babel-evaluate nil) 


;; Add custom structure templates for quickly inserting code blocks
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;; Treemacs configuration
(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-project-follow-mode)
  (treemacs-follow-mode 1) ;; Automatically follow current file
  (treemacs-filewatch-mode t) ;; Watch file changes
  (setq treemacs-width 30
        treemacs-is-never-other-window t)
  ;; Bind M-0 to select or open Treemacs
  (define-key global-map (kbd "M-0") 'treemacs-select-window))


;; Set up LSP mode for programming languages
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (python-mode . lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode)
  :custom
  (lsp-diagnostics-provider :flycheck)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-modeline-diagnostics-enable nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom (setq lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp
  :config (lsp-treemacs-sync-mode 1))

;; Set up company mode for better autocomplete
(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)  ;; Enable company-mode in programming modes
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection)  ;; Tab to complete in the dropdown
         :map lsp-mode-map
              ("<tab>" . company-indent-or-complete-common))  ;; Tab for indent or completion
  :custom
  (company-minimum-prefix-length 1)  ;; Start completion after typing 1 character
  (company-idle-delay 0.0))          ;; No delay before showing suggestions

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))  ;; Enable company-box for better visuals


;; Set up evil nerd commenter for better keybinding comment
(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

;;;; Setup python interpreter

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

(setq python-shell-completion-native-enable nil)
(setq python-shell-completion-native-disabled-interpreters '("python3"))

(use-package pyvenv
  :config
  (pyvenv-mode 1))

;; Clean up the Python shell output
(defun python-comint-filter (output)
  "Clean up shell output by removing unwanted evaluation metadata."
  (replace-regexp-in-string "__PYTHON_EL_eval.+\n" "" output))
(add-to-list 'comint-preoutput-filter-functions #'python-comint-filter)

;; Suppress "__PYTHON_EL_eval" in echo area
(setq set-message-function
      (lambda (msg)
        (if (and msg (string-match "__PYTHON_EL_eval" msg))
            nil ; Suppress unwanted messages
          msg))) ; Allow other messages




;; (use-package lsp-mode
;;   :hook ((c-mode c++-mode objc-mode) . lsp)
;;   :config
;;   (setq lsp-clients-ccls-executable "/path/to/ccls"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(modus-themes pyvenv python-mode evil-nerd-commenter lsp-treemacs lsp-ui company-box lsp-mode counsel ivy-rich ivy rainbow-delimiters company command-log-mode)))

