def main [--toggle: string, --inc, --dec] {
  if $toggle == "mute" { toggle-mute }
  if $inc { inc }
  if $dec { dec }
}

def toggle-mute [] {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  if (get-volume | get muted) {
    notify-send -i audio-volume-muted 'Volume Muted' -t 3000
  } else {
    notify-send -i audio-volume-high 'Volume Unmuted' -t 3000
  }
}

def inc [] {
  let vol = get-volume | get volume
  if ($vol < 95) {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  } else if ($vol < 100) {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
  }
}

def dec [] {
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
}

def get-icon-name [] {
}

# Returns parsed table with the following fields:
# volume=(\d.\d+), muted = "MUTED" or ""
def get-volume [] {
  let volText = wpctl get-volume @DEFAULT_AUDIO_SINK@
    | parse -r 'Volume: (?P<volume>\d.\d+)(?: \[(?<muted>MUTED)\])?'

  return { volume: ($volText.volume.0 | into float | $in * 100 | into int)
         , muted: ($volText.muted.0 | is-not-empty)
         }
}
