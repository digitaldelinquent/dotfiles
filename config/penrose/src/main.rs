#[macro_use]
extern crate penrose;

use penrose::core::{Layout, WindowManager, XcbConnection};
use penrose::helpers::spawn;
use penrose::layout::{bottom_stack, side_stack, LayoutConf};
use penrose::{Backward, Config, Forward, More};

use penrose::contrib::extensions::Scratchpad;
use penrose::contrib::hooks::{LayoutSymbolAsRootName, RemoveEmptyWorkspaces};
use penrose::contrib::layouts::paper;

use simplelog::{LevelFilter, SimpleLogger};

fn my_layouts() -> Vec<Layout> {
    let n_main = 1;
    let ratio = 0.5;
    let follow_focus_conf = LayoutConf {
        floating: false,
        gapless: true,
        follow_focus: true,
    };

    vec![
        Layout::new("[side]", LayoutConf::default(), side_stack, n_main, ratio),
        Layout::new("[botm]", LayoutConf::default(), bottom_stack, n_main, ratio),
        Layout::new("[papr]", follow_focus_conf, paper, n_main, ratio),
    ]
}

fn main() {
    SimpleLogger::init(LevelFilter::Debug, simplelog::Config::default()).unwrap();
    let mut config = Config::default();
    config.workspaces = vec!["v", "c", "x", "z"];
    config.bar_height = 0;
    config.border_px = 1;
    config.layouts = my_layouts();
    config.hooks = vec![
        LayoutSymbolAsRootName::new(),
        RemoveEmptyWorkspaces::new(config.workspaces.clone()),
    ];

    let sp = Scratchpad::new("alacritty", 0.8, 0.8);
    sp.register(&mut config);

    let key_bindings = gen_keybindings! {
        // Program launch
        "M-r" => run_external!("dmenu_run -i -b -p '' -fn 'DejaVu Sans-12' -nb '#282A36' -nf '#ffffff' -sb '#b18ef9' -sf '#ffffff'"),
        "M-Return" => run_external!("alacritty"),

        // client management
        "A-Tab" => run_internal!(cycle_client, Forward),
        "A-S-Tab" => run_internal!(cycle_client, Backward),
        "M-j" => run_internal!(drag_client, Forward),
        "M-k" => run_internal!(drag_client, Backward),
        "M-q" => run_internal!(kill_client),
        "M-slash" => sp.toggle(),

        "M-Tab" => run_internal!(toggle_workspace),
        "C-A-l" => run_internal!(drag_workspace, Forward),
        "C-A-h" => run_internal!(drag_workspace, Backward),

        // Layout management
        "M-grave" => run_internal!(cycle_layout, Forward),
        "M-S-grave" => run_internal!(cycle_layout, Backward),
        "M-A-Up" => run_internal!(update_max_main, More),
        // "M-A-Down" => run_internal!(update_max_main, Less),
        // "M-A-Right" => run_internal!(update_main_ratio, More),
        // "M-A-Left" => run_internal!(update_main_ratio, Less),

        "C-m" => run_internal!(detect_screens),

        "M-l" => run_internal!(exit);

        // setting up bindings for 6 possible workspaces
        forall_workspaces: config.workspaces => {
            "M-A-{}" => focus_workspace,
            "A-S-{}" => client_to_workspace,
        }
    };

    let conn = XcbConnection::new();
    let mut wm = WindowManager::init(config, &conn);
    spawn("alacritty");
    spawn("feh --bg-scale --no-fehbg ~/Pictures/mamimi_lofi_vibe.jpg");
    wm.grab_keys_and_run(key_bindings);
}
