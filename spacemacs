;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(systemd
     nginx
     typescript
     csv
     php
     python
     ansible
     javascript
     html
     shell-scripts
     yaml
     groovy
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     auto-completion
     ;; better-defaults
     emacs-lisp
     git
     (markdown :variables markdown-live-preview-engine 'vmd)
     journal
     (org :variables
          org-enable-org-journal-support t
          org-indent-mode t
          org-journal-dir "~/Sync/notes/journal/"
          org-journal-file-format "%Y%m%d.org"
          org-fast-tag-selection-single-key 'yes
          org-want-todo-bindings 'yes)

     (shell :variables
            shell-default-term-shell "/usr/bin/zsh"
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables spell-checking-enable-by-default nil)
     syntax-checking
     (ruby :variables
           ruby-version-manager 'rvm
           ruby-enable-enh-ruby-mode t
           enh-ruby-deep-indent-paren t
           enh-ruby-hanging-paren-deep-indent-level 0
           ruby-test-runner 'rspec)
     version-control
     salt
     sql
     git
     spotify
     neotree
     chrome
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)

     calendar
     google-calendar
     ranger
     graphviz
     (lsp :variables
          lsp-navigation 'both
          lsp-ui-doc-enable t
          lsp-ui-doc-include-signature t
          lsp-ui-sideline-enable nil
          lsp-ui-sideline-show-symbol nil)
     marekvue
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(doom-themes zerodark-theme jbeans-theme atom-dark-theme seeing-is-believing imenu-anywhere clues-theme flatui-theme seti-theme)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; lastest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-city-lights
                         doom-spacegrey
                         seti
                         smyx
                         monokai
                         flatui
                         doom-one
                         jbeans
                         hemisu-dark
                         hemisu-light
                         doom-molokai
                         wombat
                         apropospriate-light
                         apropospriate-dark
                         leuven
                         subatomic
                         darktooth
                         clues
                         zerodark)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   ;; dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
   dotspacemacs-mode-line-theme '(spacemacs )

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state nil

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 18
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil

   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t

   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil

   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil

   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil

   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom

   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always

   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I %t %b %f %z"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;; better separators
  (setq powerline-default-separator 'alternate)
  (load "~/.spacemacs-secrets.el.gpg")

  (require 'seeing-is-believing)
  (add-hook 'enh-ruby-mode-hook 'seeing-is-believing)

  ;; support LSP in enh-ruby-mode
  (with-eval-after-load 'lsp-mode
    (lsp-register-client
      (make-lsp-client :new-connection (lsp-stdio-connection '("solargraph" "stdio"))
                      :major-modes '(enh-ruby-mode)
                      :priority -1
                      :multi-root t
                      :server-id 'ruby-ls)))

  ;; lsp mode for ruby


  ;; zerodark custom modeline
  ;; (zerodark-setup-modeline-format)

  ;; use pry in ruby console
    (setq inf-ruby-default-implementation "pry")

  ;; convert org-table in markdown
    (defun orgtbl-to-gfm (table params)
      "Convert the Orgtbl mode TABLE to GitHub Flavored Markdown."
      (let* ((alignment (mapconcat (lambda (x) (if x "|--:" "|---"))
                                   org-table-last-alignment ""))
             (params2
              (list
               :splice t
               :hline (concat alignment "|")
               :lstart "| " :lend " |" :sep " | ")))
        (orgtbl-to-generic table (org-combine-plists params2 params))))

    ;; flymd - use firefox
    (defun my-flymd-browser-function (url)
      (let ((browse-url-browser-function 'browse-url-firefox))
        (browse-url url)))
    (setq flymd-browser-open-function 'my-flymd-browser-function)
    (setq flymd-output-directory "/tmp")
    (setq flymd-close-buffer-delete-temp-file t)


    ;; open pull-reqests directly from magit
    (defun marek/visit-pull-request-url ()
      "Visit the current branch's PR on GHE."
      (interactive)
      (browse-url
       (format "https://github.rackspace.com/%s/pull/new/%s"
               (replace-regexp-in-string
                "\\`.+github\\.rackspace\\.com:\\(.+\\)\\.git\\'" "\\1"
                (magit-get "remote"
                           (magit-get-push-remote)
                           "url"))
               (magit-get-current-branch))))

    ;; bind opening PRs to o
    (eval-after-load 'magit
      '(define-key magit-mode-map "+"
         #'marek/visit-pull-request-url))

    ;; seeing-is-believing
    (define-key ruby-mode-map (kbd ", d x") 'seeing-is-believing-run-as-xmpfilter)
    (define-key ruby-mode-map (kbd ", d c") 'seeing-is-believing-clear)
    (define-key ruby-mode-map (kbd ", d t") 'seeing-is-believing-mark-current-line-for-xmpfilter)

    ;; imenu-anywhere
    (global-set-key (kbd "C-'") #'imenu-anywhere)

    ;; disable lockfiles (problems with guard triggering twice)
    (setq create-lockfiles nil)


    (with-eval-after-load 'org
      ;; org mode keys
      (spacemacs/set-leader-keys "oc" 'org-capture)
      (spacemacs/set-leader-keys "op" 'marek/open_gtd)
      (spacemacs/set-leader-keys "oa" 'marek/org-archive-done-tasks)
      (spacemacs/set-leader-keys "oi" 'marek/org-open-inbox)
      ;; no current line highlight on org files (issues with colorscheme)
      (setq highlight-current-line-ignore-regexp "\.org\\|")

      ;; org templates
      (setq org-capture-templates
            '(
              ("p" "Personal Todo" entry (file "~/Sync/notes/inbox.org")
               "* TODO %^{Brief Description} :@personal:\n\t%?\n:PROPERTIES:\n:ADDED: %U\n:END:")
              ("w" "Work Todo" entry (file "~/Sync/notes/inbox.org")
               "* TODO %^{Brief Description} :@work:\n\t%?\n:PROPERTIES:\n:ADDED: %U\n:END:")
              ("a" "Appointment" entry (file  "~/Sync/notes/calendar/cal_skrobul.org") "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
            ))

      ;; Archive all DONE tasks in a buffer
      (defun marek/org-archive-done-tasks ()
        (interactive)
        (org-map-entries (lambda ()
                          (org-archive-subtree)
                          (setq  org-map-continue-from (outline-previous-heading)))
                        "/DONE|CANCELLED" 'file))

      ;; bind keys
      (defun marek/open_gtd ()
        " Open GTD file immediately"
        (interactive)
        (find-file "~/Sync/notes/gtd.org")
      )

      (defun marek/org-open-inbox ()
        "Open GTD Inbox"
        (interactive)
        (find-file "~/Sync/notes/inbox.org")
      )

      ;; render images inline by default
      (setq org-startup-with-inline-images t)

      ;; automatic visual indentation
      (setq org-startup-indented t)

      ;; inline for dot graphs
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((dot . t) (ruby . dot))
       )
      (setq org-confirm-babel-evaluate nil)

      ;; custom link types
      ;; https://orgmode.org/manual/Link-abbreviations.html#Link-abbreviations
      (setq org-link-abbrev-alist
            '(("gh"        . "http://github.com/")
              ("ghe"       . "http://github.rackspace.com/")
              ("twitter"   . "https://twitter.com/")
              ("google"    . "http://www.google.com/search?q=")
              ("gmap"      . "http://maps.google.com/maps?q=%s")
              )
      )

      ;; custom agenda
      (setq org-agenda-custom-commands
            '(
              ("p" . "Personal searches")
              ("pa" tags-todo "+@personal")
              ("pc" tags-todo "+@personal+@call")
              ("pe" tags-todo "+@personal+@errand")
              ("w" tags-todo "+@work")
              ("xs" todo "STARTED")
              ("xw" todo "WAITING")
              ("xW" todo-tree "WAITING")
              ))
      ;; refile
      (setq org-refile-targets '(("~/Sync/notes/gtd.org" :maxlevel . 1)))

      ;; auto revert for some files
      (add-hook 'org-mode-hook 'enable-auto-revert-for-org)
      (defun enable-auto-revert-for-org ()
        (when (or
                  (string= (file-name-base (or buffer-file-name "")) "inbox")
                  (string= (file-name-base (or buffer-file-name "")) "gtd"))
          (auto-revert-mode)
        )
      )
    )

    ;; fix Ctrl-R for terminal(
    (defun marek/setup-term-mode ()
      (evil-local-set-key 'insert (kbd "C-r") 'marek/send-C-r))

    (defun marek/send-C-r ()
      (interactive)
      (term-send-raw-string "\C-r"))

    (add-hook 'terminal-mode-hook 'marek/setup-term-mode)

    ;; spaceline
    (spaceline-toggle-minor-modes-off)
    (spaceline-toggle-purpose-off)
    (spaceline-toggle-line-off)
    (spaceline-toggle-buffer-encoding-abbrev-off)

    ;; zooming keys
    (define-key global-map (kbd "C-+") 'text-scale-increase)
    (define-key global-map (kbd "C--") 'text-scale-decrease)

    ;; auto-fill mode for all text buffers
    (add-hook 'text-mode-hook 'turn-on-auto-fill)
    (add-hook 'org-mode-hook 'turn-on-auto-fill)

    ;; use emacs as GIT_EDITOR
    (global-git-commit-mode t)

    ;; js2 mode - no semicolons needed
    (setq js2-strict-missing-semi-warning nil)

    ;; add YARN bin to path
    (setq exec-path (append exec-path '("/home/skrobul/.config/yarn/global/node_modules/.bin")))

)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(beacon-color "#eab4484b8035")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(evil-emacs-state-cursor (quote ("#E57373" hbar)) t)
 '(evil-insert-state-cursor (quote ("#E57373" bar)) t)
 '(evil-normal-state-cursor (quote ("#FFEE58" box)) t)
 '(evil-visual-state-cursor (quote ("#C5E1A5" box)) t)
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#37474f")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (quote
    ("#FFEE58" "#C5E1A5" "#80DEEA" "#64B5F6" "#E1BEE7" "#FFCC80")))
 '(highlight-symbol-foreground-color "#E0E0E0")
 '(highlight-tail-colors (quote (("#eab4484b8035" . 0) ("#424242" . 100))))
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(hl-sexp-background-color "#1c1f26")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (seti-theme ample-theme inkpot-theme flatland-theme tao-theme gotham-theme moe-theme color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow zenburn-theme flatui-theme lsp-ui zerodark-theme yasnippet-snippets yapfify xterm-color ws-butler writeroom-mode winum which-key web-mode web-beautify vue-mode volatile-highlights vmd-mode vi-tilde-fringe uuidgen use-package treemacs-projectile treemacs-evil toc-org tide tagedit systemd symon subatomic-theme string-inflection sql-indent spotify spaceline-all-the-icons smyx-theme smeargle slim-mode shell-pop seeing-is-believing scss-mode sass-mode salt-mode rvm ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocop rspec-mode robe restart-emacs rbenv ranger rake rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode prettier-js popwin pippel pipenv pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode password-generator paradox overseer orgit org-projectile org-present org-pomodoro org-mime org-journal org-gcal org-download org-bullets org-brain open-junk-file nginx-mode neotree nameless multi-term move-text monokai-theme minitest markdown-toc magit-svn magit-gitflow macrostep lsp-vue lorem-ipsum livid-mode live-py-mode link-hint json-navigator json-mode js2-refactor js-doc jinja2-mode jbeans-theme insert-shebang indent-guide importmagic impatient-mode imenu-anywhere ibuffer-projectile hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hemisu-theme helm-xref helm-themes helm-swoop helm-spotify-plus helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag groovy-mode groovy-imports graphviz-dot-mode google-translate golden-ratio gnuplot gmail-message-mode gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy font-lock+ flyspell-correct-helm flymd flycheck-pos-tip flycheck-bashate flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help enh-ruby-mode emmet-mode elisp-slime-nav editorconfig edit-server dumb-jump drupal-mode dotenv-mode doom-themes doom-modeline diminish diff-hl define-word darktooth-theme cython-mode csv-mode counsel-projectile company-web company-tern company-statistics company-shell company-php company-lsp company-ansible company-anaconda column-enforce-mode clues-theme clean-aindent-mode chruby centered-cursor-mode calfw-org calfw bundler browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile atom-dark-theme apropospriate-theme ansible-doc ansible aggressive-indent ace-link ace-jump-helm-line ac-ispell)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#3a513a513a51")
 '(pos-tip-foreground-color "#9E9E9E")
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(tabbar-background-color "#353335333533")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(spaceline-evil-normal ((t (:background "#2F3841" :foreground "#3E3D31" :inherit (quote mode-line))))))
)

