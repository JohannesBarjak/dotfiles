def main [--toggle: string] {
  if $toggle == "mute" { toggle-mute }
}

def toggle-mute [] {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  if (get-volume | get muted.0 | is-empty) {
    notify-send -i audio-volume-high 'Volume Unmuted' -t 3000
  } else {
    notify-send -i audio-volume-muted 'Volume Muted' -t 3000
  }
}

# Returns parsed table with the following fields:
# volume=(\d.\d+), muted = "MUTED" or ""
def get-volume [] {
  let volume = wpctl get-volume @DEFAULT_AUDIO_SINK@
  return ($volume | parse -r 'Volume: (?P<volume>\d.\d+)(?: \[(?<muted>MUTED)\])?')
}
