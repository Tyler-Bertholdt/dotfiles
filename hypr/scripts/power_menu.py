#!/usr/bin/env python3

import gi
import subprocess
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

class PowerMenu(Gtk.Window):
    def __init__(self):
        super().__init__(title="Power Menu")
        self.set_border_width(10)
        self.set_resizable(False)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_decorated(False)
        self.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.20, 0.20, 0.30, 0.5))  # Dark background

        grid = Gtk.Grid(column_spacing=10, row_spacing=10)
        self.add(grid)

        actions = [
            ("system-shutdown", "Shutdown", "systemctl poweroff"),
            ("system-reboot", "Reboot", "systemctl reboot"),
            ("system-log-out", "Logout", "hyprctl dispatch exit"),
            ("system-lock-screen", "Lock", "hyprlock"),
            ("media-playback-pause", "Suspend", "systemctl suspend"),
            ("weather-clear-night", "Hibernate", "systemctl hibernate"),
            ("window-close", "Exit", None),
        ]

        for i, (icon_name, label, command) in enumerate(actions):
            button = Gtk.Button()
            button.set_relief(Gtk.ReliefStyle.NONE)
            button.set_always_show_image(True)

            icon = Gtk.Image.new_from_icon_name(icon_name, Gtk.IconSize.DIALOG)
            button.set_image(icon)
            button.set_label(label)
            button.set_tooltip_text(label)
            button.set_size_request(50, 22)
            button.get_style_context().add_class("suggested-action")  # for hover effect

            button.connect("clicked", self.on_click, command)
            grid.attach(button, i % 3, i // 3, 1, 1)

    def on_click(self, widget, command):
        if command:
            subprocess.call(command, shell=True)
        Gtk.main_quit()

def main():
    css = b"""
    button {
        background: #2e3440;
        color: white;
        border-radius: 8px;
        font-weight: bold;
        padding: 10px;
        transition: 200ms;
    }
    button:hover {
        background: #4c566a;
    }
    """
    style_provider = Gtk.CssProvider()
    style_provider.load_from_data(css)
    Gtk.StyleContext.add_provider_for_screen(
        Gdk.Screen.get_default(),
        style_provider,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
    )

    win = PowerMenu()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
