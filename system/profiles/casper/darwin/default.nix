{...}: {
  imports = [
    ./brew.nix
  ];

  system.defaults.dock.persistent-apps = [
    "/System/Applications/System Settings.app"
    "/Applications/Arc.app"
    "/System/Applications/Messages.app"
    "/System/Applications/FaceTime.app"
    "/System/Applications/Mail.app"
    # "/Applications/WeChat.app"
    # "/Applications/WhatsApp.app"
    # "/Applications/Discord.app"
    "/System/Applications/Calendar.app"
    "/System/Applications/Notes.app"
    "/System/Applications/Freeform.app"
    "/Applications/Obsidian.app"
    # "/Applications/Notion.app"
    "/Applications/Ghostty.app"
    "/Applications/Antigravity.app"
    "/Applications/Antigravity IDE.app"
    "/Applications/Gemini.app"
    "/Applications/GitHub Desktop.app"
  ];
}
