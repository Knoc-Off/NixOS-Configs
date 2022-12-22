{ pkgs, ... }:
{

    home.packages = with pkgs; [
      wl-clipboard
    ];
    programs.tmux = {
      enable = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      prefix = "M-z"; # Alt z or smt
      # unbind all?
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.yank
      ];

      extraConfig = ''
        unbind v
        unbind h

        unbind % # Split vertically
        unbind '"' # Split horizontally

        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"

        bind -n M-Left select-pane -L
        bind -n M-Down select-pane -D
        bind -n M-Up select-pane -U
        bind -n M-Right select-pane -R

        bind -n M-S-Up resize-pane -U
        bind -n M-S-Down resize-pane -D
        bind -n M-S-Left resize-pane -L
        bind -n M-S-Right resize-pane -R



        # Should find a toggle on this
        set -g mouse on
        bind -n M-m set-option -gF mouse "#{?mouse,off,on}"\; display-message "#{?mouse,Mouse: ON,Mouse: OFF}"

        bind -T copy-mode    DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "wl-copy"
        bind -T copy-mode-vi DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "wl-copy"
        bind -n DoubleClick1Pane select-pane \; copy-mode -M \; send -X select-word \; send -X copy-pipe-no-clear "wl-copy"
        bind -T copy-mode    TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "wl-copy"
        bind -T copy-mode-vi TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "wl-copy"
        bind -n TripleClick1Pane select-pane \; copy-mode -M \; send -X select-line \; send -X copy-pipe-no-clear "wl-copy"
        bind -n MouseDown2Pane run "tmux set-buffer -b primary_selection \"$(wl-paste -p)\"; tmux paste-buffer -b primary_selection; tmux delete-buffer -b primary_selection"
        #bind -n MouseDown3Pane set-option -gF mouse "#{?mouse,off,on}"\; display-message "#{?mouse,Mouse: ON,Mouse: OFF}"

        bind -T copy-mode    C-c send -X copy-pipe-no-clear "wl-copy"
        bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "wl-copy"

        set -g default-terminal 'screen-256color'
        set -ga terminal-overrides ',*256col*:Tc'
        set -ag terminal-overrides ",alacritty:RGB,xterm-256color:RGB,gnome*:RGB"

      '';

    };

    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "alacritty";
        window = {
          decorations = "full"; # none
	  startup_mode = "Fullscreen";
          title = "Terminal";
          dynamic_title = true;
          dimensions = {
            columns = 120;
            lines = 30;
          };  
          padding = {
            x = 0;
            y = 0;
          };
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };
	cursor = {
          style = "Beam";

	};
	mouse = {
          #double_click: { threshold: 300 }
          #triple_click: { threshold: 300 }
	};
	#background_opacity = 0.90;
        key_bindings = [
	{
          key = "F11";
          action = "ToggleFullscreen";
        }
	{
	  key = "R";
	  mods = "Alt";
	  action = "ResetFontSize";

	}
	{ 
	  key = "V";
	  mods = "Control|Shift";
	  action = "Paste";
	}
	{
	  key = "N";
	  mods = "Alt";
	  action = "SpawnNewInstance";
	}
	{ 
	  key = "Insert";
	  mods = "Shift";
	  action = "PasteSelection";
	}
	];
        font = {
          normal = {
            family = "Hack";
            style = "regular";
          };
          bold = {
            family = "Hack";
            style = "regular";
          };
          italic = {
            family = "Hack";
            style = "regular";
          };
          bold_italic = {
            family = "Hack";
            style = "regular";
          };
          size = 15.00;
        };
        shell = {
          program = "/usr/bin/env";
          args = [
              "tmux"
            ];
        };
        colors = {
          primary = {
            background = "#1d1f21";
            foreground = "#c5c8c6";
          };
        };
    };
  };
}
