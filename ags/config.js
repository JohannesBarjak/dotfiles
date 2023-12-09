import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, just make it a function
// then you can use it by calling simply calling it

const Workspaces = () => Widget.Box (
    { className: 'workspaces'
    , connections:
        [[Hyprland.active.workspace, self => {
            // generate an array [1..10] then make buttons from the index
            const arr = Array.from({ length: 10 }, (_, i) => i + 1);

            self.children = arr.map(i => Widget.Button (
                { onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`)
                , child: Widget.Label(`${i}`)
                , className: Hyprland.active.workspace.id == i ? 'focused' : ''
                }
            ));
        }]]
    }
);

const Clock = () => Widget.Label (
    { className: 'clock'
    , connections:
        [[ 1000, self => execAsync(['date', '+%I:%M:%S'])
                .then(date => self.label = date).catch(console.error)
        ]]
    }
);

const Notification = () => Widget.Box (
    { className: 'notification'
    , children:
        [ Widget.Icon (
            { icon: 'preferences-system-notifications-symbolic'
            , connections:
                [ [Notifications, self => self.visible = Notifications.popups.length > 0]
                ]
            })

        , Widget.Label (
            { connections: [[Notifications, self => { self.label = Notifications.popups[0]?.summary || '' }]]
            })
        ]
    }
);

const Volume = () => Widget.Box (
    { className: 'volume'
    , css: 'min-width: 180px'
    , children:
        [ Widget.Slider (
            { hexpand: true
            , drawValue: false
            , onChange: ({ value }) => Audio.speaker.volume = value
            , connections: [[Audio, self =>
                { self.value = Audio.speaker?.volume || 0;
                }, 'speaker-changed']],
            })
        ]
    }
);

const BatteryLabel = () => Widget.Box (
    { className: 'battery'
    , children:
        [ Widget.ProgressBar (
            { vpack: 'center'
            , connections: [[Battery, self => {
                if (Battery.percent < 0)
                    return;

                self.fraction = Battery.percent / 100;
            }]],
            })
        ]
    }
);

const SysTray = () => Widget.Box (
    { connections: [[SystemTray, self => {
        self.children = SystemTray.items.map(item => Widget.Button (
            { child: Widget.Icon({ binds: [['icon', item, 'icon']] })
            , onPrimaryClick: (_, event) => item.activate(event)
            , onSecondaryClick: (_, event) => item.openMenu(event)
            , binds: [['tooltip-markup', item, 'tooltip-markup']]
            }
        ));
    }]],
    }
);

// layout of the bar
const Left = () => Widget.Box (
    { children: [ Workspaces() ]
    });

const Center = () => Widget.Box (
    { children:
        [ Clock()
        , Notification()
        ]
    });

const Right = () => Widget.Box (
    { hpack: 'end'
    , children:
        [ Volume()
        , BatteryLabel()
        , SysTray()
        ]
    });

const Bar = ({ monitor } = {}) => Widget.Window (
    { name: `bar-${monitor}` // name has to be unique
    , className: 'bar'
    , monitor
    , anchor: ['top', 'left', 'right']
    , exclusive: true
    , child: Widget.CenterBox(
        { startWidget: Left()
        , centerWidget: Center()
        , endWidget: Right()
        })
    }
);

// exporting the config so ags can manage the windows
export default
    { style: App.configDir + '/style.css'
    , windows: [ Bar() ]
    };
