
;;; leaf manager load

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
      :ensure t
      :init
      ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
      (leaf hydra :ensure t)
      (leaf el-get :ensure t)
      (leaf blackout :ensure t)

      :config
      ;; initialize leaf-keywords.el
      (leaf-keywords-init)))
;; </leaf-install-code>

(leaf feather
    :el-get conao3/feather.el
    :config
    (feather-mode))
(defcustom leaf-alias-keyword-alist '((:ensure . :feather))
  "The alias keyword.  KEY is treated as an alias for VALUE."
  :type 'sexp
  :group 'leaf)

(leaf leaf-tree :ensure t)
(leaf leaf-convert :ensure t)
(leaf transient-dwim
    :ensure t
    :bind (("M-=" . transient-dwim-dispatch)))


;;; Packages
;; ===== Appearance =====
;; (leaf solarized-theme
;;   :ensure t
;;   :config
;;   (load-theme 'solarized-dark t))
'(leaf monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t)
  (setq monokai-user-variable-pitch t))
(leaf highlight-symbol :ensure t)
'(leaf powerline
  :ensure t
  :config
  (powerline-default-theme))
(leaf doom-themes
    :ensure t
    :config
    (setq doom-themes-enable-bold t
	  doom-themes-enable-italic t)
    (load-theme 'doom-molokai t)
    (doom-themes-visual-bell-config)
    (doom-themes-neotree-config)
    (doom-themes-org-config))
(leaf doom-modeline
    :ensure t
    :hook (after-init-hook . doom-modeline-mode)
    :config
    (setq doom-modeline-icon (display-graphic-p))
    (setq doom-modeline-major-mode-icon t)
    (setq doom-modeline-major-mode-color-icon t)
    (setq doom-modeline-buffer-state-icon t)
    (setq doom-modeline-buffer-modification-icon t)
    (setq doom-modeline-unicode-fallback t)
    (setq doom-modeline-buffer-encoding t)
    (setq doom-modeline-lsp t)
    (setq doom-modeline-github nil)
    (setq doom-modeline-env-version t)
    (setq doom-modeline-env-load-string "...")
    (setq doom-modeline-enable-word-count t))
(leaf all-the-icons :ensure t)
'(leaf emojify
  :ensure t
  :hook (after-init-hook . global-emojify-mode))
(leaf color-identifiers-mode
    :ensure t
    :hook (after-init-hook . global-color-identifiers-mode))
(leaf hl-line
    :ensure t
    :hook (after-init-hook . global-hl-line-mode))
(leaf paren
    :ensure t
    :hook (after-init-hook . show-paren-mode)
    :custom
    (show-paren-when-point-inside-paren . t)
    (show-paren-when-point-in-periphery . t))
'(leaf hl-todo
    :ensure t
    :hook (prog-mode-hook . global-hl-todo-mode))
(leaf diff-hl
    :ensure t
    :hook ((dired-mode-hook . diff-hl-dired-mode-unless-remote)
	   (after-init-hook . global-diff-hl-mode))
    :config
    (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
(leaf rainbow-delimiters
    :ensure t
    :hook (prog-mode-hook . rainbow-delimiters-mode))
(leaf highlight-indentation
    :hook (prog-mode-hook . highlight-indentation-current-column-mode))
(leaf company-box
    :ensure t
    :hook (company-mode-hook . company-box-mode))

;; ===== Project Management =====
(leaf neotree
    :ensure t
    :init
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
(leaf dash
  :ensure t)
(leaf projectile
    :ensure t
    :hook (prog-mode-hook . projectile-mode))
(leaf magit
    :ensure t)

;; ===== Completion & Diagnoise =====
(leaf company
    :ensure t
    :config
    (setq lsp-completion-provider :capf)
    (global-company-mode))
(leaf yasnippet
    :ensure t
    :config
    (yas-global-mode 1))
(leaf yasnippet-snippets :ensure t)
(leaf ivy
    :ensure t
    :init
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (ivy-mode 1))
(leaf counsel :ensure t)
(leaf smex
    :ensure t
    :config
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    ;; This is your old M-x.
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))
(leaf flymake :ensure t)
(leaf eldoc :ensure t)
(leaf flycheck
    :ensure t
    :hook ((after-init-hook . global-flycheck-mode)
	   (lsp-mode-hook   . flycheck-mode)
	   (irony-mode-hook . irony-eldoc)
	   ))

;; ===== Language Specific =====
;; ~~~ LSP ~~~
(leaf lsp-mode
    :ensure t
    :hook ((haskell-mode-hook . lsp)
	   (haskell-mode-hook . lsp-mode)
	   (c++-mode-hook     . lsp)
	   (c-mode-hook       . lsp-mode))
    :config
    (lsp-enable-imenu)
    (setq lsp-file-watch-thresold nil))
(leaf lsp-ui
    :ensure t
    :hook ((lsp-mode-hook     . lsp-ui-mode)
	   (haskell-mode-hook . lsp-ui-mode)
	   (c++-mode-hook     . lsp-ui-mode)
	   (c-mode-hook       . lsp-ui-mode)))
(leaf lsp-ui-sideline)
(leaf lsp-ui-peek)
(leaf lsp-treemacs
    :ensure t
    :commands lsp-treemacs-errors-list)
(leaf helm-lsp
    :ensure t
    :commands helm-lsp-workspace-symbol)
(leaf company-quickhelp
    :ensure t)

;; ~~~ Org ~~~
(leaf org-mode
    :ensure t
    :config
    (setq org-pretty-entities t))
(leaf org-babel
    :ensure t)

;; ~~~ Common Lisp ~~~
(leaf slime-company
    :ensure t)

(leaf slime
    :ensure t
    :hook (slime-mode-hook
	   . (lambda ()
	       (unless (slime-connected-p)
		 (save-excursion (slime)))))
    :config
    ;; Set your lisp system and, optionally, some contribs
    (setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
    (setq slime-contribs '(slime-fancy slime-indentation))
    (setq lisp-indent-function 'common-lisp-indent-function)
    (setq common-lisp-style-default "modern")
    (slime-setup '(slime-fancy slime-company)))

;; ~~~ Coq ~~~
(leaf company-coq
    :ensure t
    :hook (coq-mode-hook . company-coq-mode))

(leaf proof-general
    :ensure t)

;; ~~~ Python ~~~
(leaf python
    :ensure t
    :mode ("\\.py\\'" . python-mode)
    :interpreter ("python" . python-mode))
(leaf elpy
    :ensure t
					; :defer t
    :init
    (advice-add 'python-mode :before 'elpy-enable))

;; ~~~ Lua ~~~
(leaf flymake-lua :ensure t)
(leaf lua-mode :ensure t)
(leaf company-lua :ensure t)

;; ~~~ Markdown ~~~
(leaf markdown-mode
    :ensure t)
(leaf markdown-preview-eww
    :ensure t)

;; ~~~ Haskell ~~~
(leaf haskell-mode
    :ensure t
    :config
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'haskell-font-lock-symbols t)
    (define-key haskell-mode-map (kbd "C-c C-h C-l") 'haskell-process-load-or-reload)
    (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
					;  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
					;  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
					;  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
					;  (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
					;  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
					;  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
					;  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
					;  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
					;  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
    :hook ((haskell-mode-hook . interactive-haskell-mode)
	   (haskell-mode-hook . company-mode)
	   (haskell-mode-hook . intero-mode)
	   (haskell-mode-hook . lsp-mode)))
(leaf haskell-interactive-mode)
(leaf haskell-process)
(leaf flymake-hlint :ensure t)
'(leaf intero
  :ensure t
  :config
  (intero-global-mode 1))
'(leaf lsp-haskell
  :ensure t
  :config
  (lsp-haskell-set-hlint-on)
  (lsp-haskell-set-completion-snippets-on)
  (add-hook 'haskell-mode-hook #'lsp))
(leaf hindent
    :ensure t
    :hook (haskell-mode-hook . hindent-mode)
    :config
    (setq exec-path `("/home/pe200012/.local/bin" ,@exec-path)))

;; ~~~ OCaml ~~~
(leaf utop :ensure t)

;; ~~~ Moonscript ~~~
(leaf moonscript :ensure t)

;; ~~~ Yaml ~~~
(leaf yaml-mode :ensure t)
(leaf flymake-yaml :ensure t)

;; ~~~ C & C++ ~~~
;; (leaf irony
;;   :ensure t
;;   :hook ((c++-mode   . irony-mode)
;; 	 (c-mode     . irony-mode)
;; 	 (objc-mode  . irony-mode)
;; 	 (irony-mode . irony-cdb-autosetup-compile-options)))
;; (leaf flycheck-irony
;;   :ensure t
;;   :config
;;   (eval-after-load 'flycheck
;;     '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))
;; (leaf company-irony
;;   :ensure t
;;   :config
;;   (eval-after-load 'company
;;     '(add-to-list 'company-backends 'company-irony)))
;; (leaf clang-format
;;  :ensure t)
(leaf ccls
    :ensure t
    :hook ((c-mode-hook c++-mode-hook objc-mode-hook cuda-mode-hook) .
	   (lambda () (require 'ccls) (lsp)))
    :config
    (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t) t))
    (setq lsp-prefer-flymake nil)
    (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
    (setq ccls-sem-highlight-method 'font-lock)
    (ccls-use-default-rainbow-sem-highlight)
    (define-key c++-mode-map (kbd "C-'") 'company-lsp))
'(leaf flycheck-rtags
  :ensure t)

;; ~~~ Ruby ~~~
(leaf ruby-mode)
(leaf enh-ruby-mode
    :ensure t
    :config
    (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
    (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist
		 '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
    )
(leaf inf-ruby :ensure t)
(leaf yari :ensure t)
(leaf ruby-tools :ensure t)
(leaf ruby-electric :ensure t)
(leaf rvm
    :ensure t
    :config
    (rvm-use-default))
(leaf seeing-is-believing
    :ensure t
    :config
    (setq seeing-is-believing-prefix "C-,"))
(leaf rubocop :ensure t)
(leaf robe
    :ensure t
    :config
    (eval-after-load 'company
      '(push 'company-robe company-backends)))

;; ===== Web Development =====
'(leaf tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode-hook . tide-setup)
	 (typescript-mode-hook . tide-hl-identifier-mode)
	 (before-save-hook . tide-format-before-save)
	 (typescript-mode-hook . company-tide)))
'(leaf web-mode :ensure t)
'(leaf jsx-mode :ensure t)
'(leaf js2-mode :ensure t)
'(leaf emmet-mode
  :ensure t
  :hook (sgml-mode css-mode))
'(leaf skewer-mode
  :ensure t
  :hook (js2-mode css-mode html-mode))
'(leaf simple-httpd :ensure t)

;; ===== Utils =====
(leaf smartparens :ensure t)
(leaf spinner :ensure t)
(leaf paradox :ensure t)
(leaf ido
    :config
  (ido-mode t))
(leaf multiple-cursors :ensure t)
(leaf smart-cursor-color :ensure t)
(leaf wakatime-mode
    :ensure t
    :config
        (global-wakatime-mode))


(provide '.emacs-packages)
;;; .emacs-packages ends here


